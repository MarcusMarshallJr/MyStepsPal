//
//  ChangeGoalScreen.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import SwiftUI

struct ChangeGoalSheet: View {
   
   @State var stepGoal: Int
   var goalIncrement: Int = 500
   var onDismissTapped: () -> Void
   var onChangeStepGoalConfirmed: (Int) -> Void
   
    var body: some View {
       VStack {
          dismissButton
          viewGreeting
          Spacer()
          goalChangeControls
          Spacer()
          BrandButton(title: "Change Step Goal", 
                      onTap: handleChangeGoalConfirmedTapped)
          Text("Your daily goal will update for today and previous days.")
             .brandFont(size: 14, color: BrandColors.N900)
             .multilineTextAlignment(.center)
          
       }.padding(.horizontal, BrandConstants.sidePadding)
    }
}

//MARK: - Components
extension ChangeGoalSheet {
   private var dismissButton: some View {
      HStack {
         Button(action: onDismissTapped) {
            Text("Dismiss")
               .brandButtonText()
         }
         Spacer()
      }
      .padding(.vertical)
   }
   private var viewGreeting: some View {
      VStack(spacing: 8) {
         Text("Your Daily Step Goal")
            .brandTitle()
         Text("Set a goal for the number of steps you’d like to reach each day.")
            .brandSubtitle()
      }.multilineTextAlignment(.center)
   }
   
   private var goalChangeControls: some View {
      VStack {
         HStack(spacing: 24) {
            Button(action: handleDecreaseGoal) {
               Image(systemName: "minus.circle.fill")
                  .font(.system(size: 50))
                  .foregroundStyle(BrandColors.B500)
            }
            Text("\(stepGoal)")
               .brandProminentNumber(color: BrandColors.N900)
            Button(action: handleIncreaseGoal) {
               Image(systemName: "plus.circle.fill")
                  .font(.system(size: 50))
                  .foregroundStyle(BrandColors.B500)
            }
         }
         Text("Steps per Day".uppercased())
            .brandSubtitle(color: BrandColors.B500)
      }
   }
}


//MARK: - Functions
extension ChangeGoalSheet {
   private func handleDecreaseGoal() {
      let newStepGoal = self.stepGoal - goalIncrement
      
      guard newStepGoal >= goalIncrement else { return }
      
      self.stepGoal = newStepGoal
      
   }
   
   private func handleIncreaseGoal() {
      stepGoal += goalIncrement
   }
   private func handleChangeGoalConfirmedTapped() {
      onChangeStepGoalConfirmed(stepGoal)
   }
}

#Preview {
   ChangeGoalSheet(stepGoal: 5000,
                    onDismissTapped: {},
                    onChangeStepGoalConfirmed: { _ in })
}
