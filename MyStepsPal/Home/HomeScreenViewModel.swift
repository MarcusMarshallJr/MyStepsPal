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
   
   let dailyStepGoal = 1600
   var pedometerService: PedometerService_Protocol
   
   
   //MARK: - Initalization
   init(pedometerService: PedometerService_Protocol) {
      self.pedometerService = pedometerService
   }
   
   
   //MARK: - Functions
   func startLiveStepData() {
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
   
   func getHistoricalStepData() async {
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


