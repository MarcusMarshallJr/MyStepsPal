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
      
      self.font(.system(size: size))
         .fontWeight(weight)
         .foregroundColor(color)
   }
    
    func brandProminentOverline(color: Color = BrandColors.N900) -> some View {
       self.brandFont(size: 16, 
                      weight: .black,
                      color: color)
    }
    
    func brandSubtleOverline(color: Color = BrandColors.N900) -> some View {
        self.brandSubtitle(color: color)
    }
    
    func brandTitle(color: Color = BrandColors.N900) -> some View {
       self.brandFont(size: 24, 
                      weight: .bold,
                      color: color)
    }
    
   func brandSubtitle(color: Color = BrandColors.N900) -> some View {
        self.brandFont(size: 16, 
                       weight: .medium,
                       color: color)
    }

    func brandProminentNumber(color: Color = BrandColors.N900) -> some View {
        self.brandFont(size: 48, 
                       weight: .black,
                       color: color)
    }
   
   func brandSubtleNumber(color: Color = BrandColors.N900) -> some View {
      self.brandTitle(color: color)
   }
   
   func brandButtonText(color: Color = BrandColors.B500) -> some View {
      self.brandFont(size: 14, weight: .bold, color: color)
   }
    
}
