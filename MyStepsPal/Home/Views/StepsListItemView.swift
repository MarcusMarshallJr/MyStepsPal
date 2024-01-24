//
//  StepsListItemView.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import SwiftUI

struct StepsListItemView: View {
   let overline: String
   let primaryText: String
   let secondaryText: String?
   let goalStatus: GoalStatus
   
   var body: some View {
      HStack {
         goalIndicator
         VStack(alignment: .leading) {
            Text(overline)
               .brandSubtleOverline(color: accentTextColor)
            Text(primaryText)
               .brandTitle(color: BrandColors.N0)
         }
         Spacer()
         if let secondaryText {
            Text(secondaryText)
               .brandFont(size: 12, weight: .medium, color: accentTextColor)
         }
      }
      .padding()
      .background(backgroundColor)
      .clipShape(RoundedRectangle(cornerRadius: 10))
   }
}

//MARK: - Helpers
extension StepsListItemView {
   var backgroundColor: Color {
      switch goalStatus {
      case .exceeded, .met:
         BrandColors.B500
      case .below:
         BrandColors.P500
      }
   }
   var indicatorCircleColor: Color {
      switch goalStatus {
      case .exceeded, .met:
         BrandColors.B900
      case .below:
         BrandColors.P900
      }
   }
   var indicatorSymbolName: String {
      switch goalStatus {
      case .exceeded:
         return "chevron.up"
      case .met:
         return "chevron.compact.up"
      case .below:
         return "chevron.down"
      }
   }
   
   var accentTextColor: Color {
      switch goalStatus {
      case .exceeded, .met:
         BrandColors.B200
      case .below:
         BrandColors.P200
      }
   }
}



//MARK: - Components
extension StepsListItemView {
   var goalIndicator: some View {
      ZStack {
         Circle()
            .fill(indicatorCircleColor)
            .frame(width: 45, height: 45)
         Image(systemName: indicatorSymbolName)
            .font(.system(size: 24))
            .foregroundStyle(.white)
      }
   }
}

#Preview {
   StepsListItemView(overline: "Wednesday", 
                     primaryText: "10,404",
                     secondaryText: "2.4 mi",
                     goalStatus: .met)
}
