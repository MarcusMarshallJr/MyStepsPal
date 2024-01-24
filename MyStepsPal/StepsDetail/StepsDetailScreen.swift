//
//  StepsDetailScreen.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import SwiftUI

struct StepsDetailScreen: View {
   
   var stepSummary: StepSummary
   
   var body: some View {
      VStack(alignment: .leading) {
         detailScreenGreeting
         allMetrics
      }.padding(.horizontal, BrandConstants.sidePadding)
   }
}

//MARK: - Components
extension StepsDetailScreen {
   var detailScreenGreeting: some View {
      VStack(alignment: .leading) {
         Text(stepSummary.longDate.uppercased())
            .brandProminentOverline()
         Text(stepSummary.stepGoalSummaryText)
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
   
   var stepGoalSummaryText: String {
      return "Fix Me"
   }
   
   var dayString: String {
      if Calendar.current.isDateInToday(self.date) {
         return "today"
      }
      
      if Calendar.current.isDateInYesterday(self.date) {
         return "yesterday"
      }
      
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "EEEE"
      return dateFormatter.string(from: self.date)
   }
   
   var longDate: String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateStyle = .long
      return dateFormatter.string(from: self.date)
   }
   
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
                                              stairsClimbed: 0))
}
