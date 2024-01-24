//
//  BrandLogo.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import SwiftUI

///A resuable view that shows the brand logo text.
struct BrandLogo: View {
   var color: Color = BrandColors.N0
   
   var body: some View {
      Text("mystepspal™")
         .brandFont(size: 24,
                    weight: .black,
                    color: color)
   }
}

#Preview {
   BrandLogo()
}
