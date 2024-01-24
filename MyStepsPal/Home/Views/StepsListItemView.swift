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
   
    var body: some View {
        HStack {
           goalIndicator
            VStack(alignment: .leading) {
                Text(overline)
                  .brandSubtleOverline()
                Text(primaryText)
                  .brandTitle()
            }
            Spacer()
           if let secondaryText {
              Text(secondaryText)
                 .brandFont(size: 12, weight: .medium)
           }
        }
        .padding()
        .background(BrandColors.N200)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}



//MARK: - Components
extension StepsListItemView {
   var goalIndicator: some View {
      ZStack {
         Circle()
            .fill(.gray)
            .frame(width: 45, height: 45)
         Image(systemName: "chevron.down")
            .font(.system(size: 24))
            .foregroundStyle(.white)
      }
   }
}

#Preview {
   StepsListItemView(overline: "Wednesday", 
                     primaryText: "10,404",
                     secondaryText: "2.4 mi")
}
