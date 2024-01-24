//
//  StepsDetailScreen.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import SwiftUI

struct StepsDetailScreen: View {
   
   var stepSummary: StepSummary
   let stepGoalStatus: GoalStatus
   
   var body: some View {
      VStack(alignment: .leading) {
         detailScreenGreeting
         allMetrics
      }.padding(.horizontal, BrandConstants.sidePadding)
   }
}

//MARK: - Helper Properties
extension StepsDetailScreen {
   var date: Date {
      return stepSummary.date
   }
   var stepGoalSummaryText: String {
      if Calendar.current.isDateInToday(date)
            && stepGoalStatus == .below {
         return "Keep it up! You can make your step goal for today!"
      }
      
      switch stepGoalStatus {
      case .exceeded:
         return "Congrats! You exceeded your step goal on \(date.dayString)."
      case .met:
         return "Whoo Hoo! You met your step goal \(date.dayString)."
      case .below:
         return "You're were bit shy of your step goal \(date.dayString)."
      }
   }
}

//MARK: - Components
private extension StepsDetailScreen {
   var detailScreenGreeting: some View {
      VStack(alignment: .leading) {
         Text(date.longDate.uppercased())
            .brandProminentOverline(color: BrandColors.B500)
         Text(stepGoalSummaryText)
            .brandTitle()
            .multilineTextAlignment(.leading)
      }
   }
   var allMetrics: some View {
      HStack(spacing: 16) {
         MetricView(value: "\(stepSummary.stepCount)", title: "steps", style: .prominent)
         Spacer()
         BrandVerticalDivider(color: BrandColors.N900)
            .frame(height: 150)
         VStack(alignment: .leading, spacing: 16) {
            if let formattedMileString = stepSummary.formattedMileString {
               MetricView(value: formattedMileString,
                          title: "distance")
            }
            
            
            MetricView(value: stepSummary.formattedStairsClimbedString,
                       title: "stairs climbed")
         }
      }
   }
}

//MARK: - Private Extensions
private extension StepSummary {
   var formattedMileString: String? {
      guard let distanceInMiles else { return nil }
      return String(format: "%0.1f mi", distanceInMiles)
   }
   var formattedStairsClimbedString: String {
      guard let numStairsClimbed,
            numStairsClimbed != 0 else {
         return "None"
      }
      
      switch numStairsClimbed {
      case 1:
         return "\(numStairsClimbed) floor"
      default:
         return "\(numStairsClimbed) floors"
      }
   }
}


#Preview {
   StepsDetailScreen(stepSummary: StepSummary(date: Date(),
                                              stepCount: 204,
                                              distanceInMiles: 3.5,
                                              stairsClimbed: 0), 
                     stepGoalStatus: .exceeded)
}
