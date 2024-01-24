//
//  HomeScreen.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import SwiftUI

struct HomeScreen: View {
   
   @StateObject var vm = HomeScreenViewModel(pedometerService: PedometerService(), 
                                             userDefaults: UserDefaults.self)
   
   var body: some View {
      NavigationStack {
         ZStack(alignment: .top) {
            ScrollView {
               VStack(spacing: 16) {
                  BrandLogo(color: BrandColors.B500)
                     .padding(.top, BrandConstants.sidePadding)
                     .padding(.bottom, 60)
                  userGreeting
                  currentStepProgress
                  stepsHistory
               }.padding(.horizontal, BrandConstants.sidePadding)
               
            }
            if let error = vm.error {
               BrandColors.N900
                  .ignoresSafeArea(.all)
                  .opacity(0.4)
               ErrorView(title: error)
            }
         }.task {
            await vm.startDataRetrival()
         }
      }.sheet(isPresented: $vm.presentStepGoalSheet) {
         ChangeGoalSheet(stepGoal: vm.dailyStepGoal,
                         onDismissTapped: vm.handleChangeGoalDismissed,
                         onChangeStepGoalConfirmed: vm.handleChangeGoalConfirmed(newGoal:))
         .presentationDetents([.medium])
      }
   }
}


//MARK: - Components
extension HomeScreen {
   var userGreeting: some View {
      VStack(spacing: 8) {
         Text("today's Steps".uppercased())
            .brandProminentOverline(color: BrandColors.B500)
         Text("Hi there, you've walked\n \(vm.todaysProgressPercentage) of your goal.")
            .brandTitle()
            .multilineTextAlignment(.center)
         BrandButton(title: "Change Goal", onTap: vm.handleChangeGoalTapped)
      }
      
   }
   
   var currentStepProgress: some View {
      NavigationLink(destination: StepsDetailScreen(stepSummary: vm.todaysStepSummary,
                                                    stepGoalStatus: vm.todaysStepSummary.stepGoalStatus(given: vm.dailyStepGoal))) {
         VStack(spacing: 16) {
            ZStack {
               ArcProgressView(progress: vm.todaysProgress)
                  .frame(width: UIScreen.main.bounds.width - 120)
               VStack {
                  Image(systemName: "figure.walk")
                     .font(.system(size: 40))
                     .foregroundStyle(BrandColors.B900)
                  
                  Text("\(vm.todaysStepSummary.stepCount)".uppercased())
                     .brandProminentNumber()
                  Text("Steps".uppercased())
                     .brandSubtleOverline(color: BrandColors.B500)
                  
               }
            }
            
            HStack(spacing: 4) {
               Text("See Today's Activity")
               Image(systemName: "chevron.right")
                  .font(.system(size: 14))
            }.foregroundStyle(BrandColors.B500)
         }
      }
   }
   
   var stepsHistory: some View {
      VStack {
         Text("Steps History")
            .brandTitle()
            .frame(maxWidth: .infinity, alignment: .leading)
         ForEach(vm.stepHistory) { item in
            NavigationLink(destination: StepsDetailScreen(stepSummary: item, stepGoalStatus: item.stepGoalStatus(given: vm.dailyStepGoal))) {
               StepsListItemView(overline: item.date.dayString,
                                 primaryText: "\(item.stepCount)",
                                 secondaryText: item.date.shortDate,
                                 goalStatus: item.stepGoalStatus(given: vm.dailyStepGoal))
            }
         }
      }
   }
}

#Preview {
   HomeScreen()
}
