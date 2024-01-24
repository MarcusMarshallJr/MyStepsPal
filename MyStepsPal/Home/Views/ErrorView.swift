//
//  ErrorView.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import SwiftUI

struct ErrorView: View {
   var title: String = ""
   var subtitle: String? = nil
   
    var body: some View {
       VStack(spacing: 4) {
          BrandLogo()
             .padding(.bottom, 8)
          Text(title)
             .brandFont(weight: .bold, color: BrandColors.N0)
             .multilineTextAlignment(.center)
          if let subtitle {
             Text(subtitle)
                .brandFont(color: BrandColors.N0.opacity(0.85))
                .multilineTextAlignment(.center)
          }
       }
       .padding()
       .frame(maxWidth: .infinity)
       .background(BrandColors.B500)
    }
}

#Preview {
   ErrorView(title: "MyStepsPal needs your permission to track steps.",
             subtitle: " To give permission, open Settings, go to Privacy, and Turn on Motion & Fitnees for MyStepsPal.")
}
