//
//  BrandVerticalDivider.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import SwiftUI

///A reusable view that displays vertical divider consistent with the brand
struct BrandVerticalDivider: View {
   var color: Color = BrandColors.N200
   
   var body: some View {
      RoundedRectangle(cornerRadius: 2)
         .fill(color)
         .frame(width: 1)
   }
}

#Preview {
   BrandVerticalDivider()
}

