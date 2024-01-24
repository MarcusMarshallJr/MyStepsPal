//
//  BrandButton.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import SwiftUI

/// A reusable button view with app specific branding.
struct BrandButton: View {
   
   /// The title text for the button
   let title: String
   
   /// The action that will take place when the button is pressed.
   var onTap: () -> Void = {}

    var body: some View {
       Button(action: onTap) {
          Text(title)
             .brandButtonText()
             .padding()
             .padding(.horizontal)
             .background(BrandColors.B200)
             .clipShape(RoundedRectangle(cornerRadius: 9))
       }
    }
}

#Preview {
    BrandButton(title: "Change Goal")
}
