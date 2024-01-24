//
//  HomeScreen.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import SwiftUI

struct HomeScreen: View {
   
   @StateObject var viewModel = HomeScreenViewModel(pedometerService: PedometerService())
   
   var body: some View {
      NavigationStack {
         ZStack(alignment: .top) {
            ScrollView {
               VStack(spacing: 16) {
                  BrandLogo(color: BrandColors.N900)
                     .padding(.top, BrandConstants.sidePadding)
                     .padding(.bottom, 60)
                  userGreeting
                  currentStepProgress
                  stepsHistory
               }.padding(.horizontal, BrandConstants.sidePadding)
                  
            }
            if let error = viewModel.error {
               BrandColors.N900
                  .ignoresSafeArea(.all)
                  .opacity(0.4)
               ErrorView(title: error)
            }
         }.task {
            await viewModel.getHistoricalStepData()
            viewModel.startLiveStepData()
         }
      }
   }
}

//MARK: - Helper Properties
extension HomeScreen {
   var todaysProgress: Double {
      return Double(viewModel.todaysStepSummary.stepCount) / Double(viewModel.dailyStepGoal)
   }
   
   var todaysProgressPercentage: String {
      return String(format: "%.0f%%", (todaysProgress * 100))
   }
}

//MARK: - Components
extension HomeScreen {
   var changeGoalButton: some View {
      Button(action: changeGoalPressed, label: {
         Text("Change Goal")
      })
   }
   
   var userGreeting: some View {
      VStack(spacing: 8) {
         Text("today's Steps".uppercased())
            .brandProminentOverline()
         Text("Hi there, you've walked\n \(todaysProgressPercentage) of your goal.")
            .brandTitle()
            .multilineTextAlignment(.center)
         changeGoalButton
      }
      
   }
   
   var currentStepProgress: some View {
      VStack(spacing: 16) {
         ZStack {
            ArcProgressView(progress: todaysProgress)
               .frame(width: UIScreen.main.bounds.width - 120)
            VStack {
               Image(systemName: "figure.walk")
                  .font(.system(size: 40))
               Text("\(viewModel.todaysStepSummary.stepCount)".uppercased())
                  .brandProminentNumber()
               Text("Steps".uppercased())
                  .brandSubtleOverline()
               
            }
         }
         NavigationLink(destination: StepsDetailScreen(stepSummary: viewModel.todaysStepSummary)) {
            HStack(spacing: 4) {
               Text("See Today's Activity")
               Image(systemName: "chevron.right")
                  .font(.system(size: 14))
            }
         }
      }
   }
   
   var stepsHistory: some View {
      VStack {
         Text("Steps History")
            .brandTitle()
            .frame(maxWidth: .infinity, alignment: .leading)
         ForEach(viewModel.stepHistory) { item in
            NavigationLink(destination: StepsDetailScreen(stepSummary: item)) {
               StepsListItemView(overline: item.dayString,
                                 primaryText: "\(item.stepCount)",
                                 secondaryText: item.shortDate )
            }
         }
      }
   }
}

//MARK: - Functions
extension HomeScreen {
   func changeGoalPressed() {
      
   }
}

//MARK: - Private Extensions
private extension StepSummary {
   var shortDate: String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateStyle = .short
      return dateFormatter.string(from: self.date)
   }
   
   var dayString: String {
      if Calendar.current.isDateInYesterday(self.date) {
         return "Yesterday"
      }
      
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "EEEE"
      return dateFormatter.string(from: self.date)
   }
}

#Preview {
   HomeScreen()
}
