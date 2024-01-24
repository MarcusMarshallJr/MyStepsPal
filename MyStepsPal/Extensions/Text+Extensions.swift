//
//  Text+Extensions.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import SwiftUI

extension Text {
    ///A convenience modifer that easily applies standard brand font styling to Text.
   func brandFont(size: CGFloat = 16,
                  weight: Font.Weight = .regular,
                  color: Color = BrandColors.N900) -> some View {
      
      self.font(.system(size: size, design: .rounded))
         .fontWeight(weight)
         .foregroundColor(color)
   }
    
    func brandProminentOverline() -> some View {
        self.brandFont(size: 16, weight: .black)
    }
    
    func brandSubtleOverline() -> some View {
        self.brandSubtitle()
    }
    
    func brandTitle() -> some View {
       self.brandFont(size: 24, weight: .bold)
    }
    
    func brandSubtitle() -> some View {
        self.brandFont(size: 16, weight: .medium)
    }

    func brandProminentNumber() -> some View {
        self.brandFont(size: 48, weight: .black)
    }
   
   func brandSubtleNumber() -> some View {
      self.brandTitle()
   }
    
}
