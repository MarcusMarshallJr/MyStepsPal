//
//  HomeScreenViewModel.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import Foundation

class HomeScreenViewModel: ObservableObject {
   
   //MARK: - Propeties
   @Published var todaysStepSummary: StepSummary = StepSummary.zeroedOutStepCount
   @Published var stepHistory: [StepSummary] = []
   @Published var error: String? = nil
   @Published var presentStepGoalSheet: Bool = false
   
   var pedometerService: PedometerService_Protocol
   var userDefaults: UserDefaults_Protocol.Type
   var dailyStepGoal: Int
   
   var todaysProgress: Double {
      return Double(todaysStepSummary.stepCount) / Double(dailyStepGoal)
   }
   var todaysProgressPercentage: String {
      return String(format: "%.0f%%", (todaysProgress * 100))
   }
   
   //MARK: - Initalization
   init(pedometerService: PedometerService_Protocol,
        userDefaults: UserDefaults_Protocol.Type) {
      self.pedometerService = pedometerService
      self.userDefaults = userDefaults
      dailyStepGoal = userDefaults.dailyStepGoal
   }
   
   
   //MARK: - Functions
   func startDataRetrival() async {
      resetUI()
      startLiveStepData()
      await getHistoricalStepData()
   }
   func handleChangeGoalTapped() {
      self.presentStepGoalSheet = true
   }
   func handleChangeGoalDismissed() {
      self.presentStepGoalSheet = false
   }
   func handleChangeGoalConfirmed(newGoal: Int) {
      userDefaults.dailyStepGoal = newGoal
      
      Task {
         await startDataRetrival()
      }
   }
   func resetUI() {
      guaranteeThisRunsOnMainThread {
         self.todaysStepSummary = StepSummary.zeroedOutStepCount
         self.stepHistory = []
         self.error = nil
         self.presentStepGoalSheet = false
         self.dailyStepGoal = self.userDefaults.dailyStepGoal
      }
   }
   
   private func startLiveStepData() {
      do {
         try pedometerService.startLivePedometerData { livePedometerData, error in
            guard let livePedometerData else {
               guaranteeThisRunsOnMainThread {
                  self.error = PedometerError.pedometerDataNil.rawValue
               }
               return
            }
            
            guard error == nil else {
               guaranteeThisRunsOnMainThread {
                  self.error = error!.localizedDescription
               }
               return
            }
            
            guaranteeThisRunsOnMainThread {
               self.todaysStepSummary = StepSummary(from: livePedometerData)
            }
         }
      } catch (let error) {
         guaranteeThisRunsOnMainThread {
            self.error = (error as! PedometerError).rawValue
         }
      }
   }
   private func getHistoricalStepData() async {
      do {
         let historicalPedometerData = try await pedometerService.retrieveSixDayHistoricalPedometerData()
         let reverseChronologicalData = historicalPedometerData
            .map({ StepSummary(from: $0)})
            .sorted(by: { $0.date > $1.date })
         
         await MainActor.run {
            self.stepHistory = reverseChronologicalData
         }
         
      } catch (let error) {
         await MainActor.run {
            
            if let pedometerError = error as? PedometerError {
               self.error = pedometerError.rawValue
            } else {
               self.error = "Unknown error"
               print(error.localizedDescription)
            }
            
            
         }
         
      }
   }
}

private extension StepSummary {
   static let zeroedOutStepCount: StepSummary = StepSummary(date: Date.startOfToday, stepCount: 0)
   
}


