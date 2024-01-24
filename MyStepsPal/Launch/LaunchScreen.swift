//
//  LaunchScreen.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import SwiftUI

struct LaunchScreen: View {
   @Binding var isShown: Bool
   
   @State private var scale: CGSize = CGSize(width: 0.8, height: 0.8)
   @State private var opacity: CGFloat = 1.0
   
   @State private var brandLogoColor: Color = BrandColors.N0
   @State private var brandLogoOffset: CGFloat = 0
   
   
   var body: some View {
      ZStack {
         background
            .opacity(opacity)
         VStack {
            Spacer()
            appLogo
               .scaleEffect(scale)
               .opacity(opacity)
            BrandLogo(color: brandLogoColor)
               .offset(y: brandLogoOffset)
            
            Spacer()
            imageAttribution
         }.padding(BrandConstants.sidePadding)
      }.onAppear {
         runStartAnimation()
      }
   }
}

//MARK: - Components
extension LaunchScreen {
   var background: some View {
      BrandColors.B500
         .ignoresSafeArea(.all)
   }
   var appLogo: some View {
      
      Image("noun-student-walking-6202530")
         .resizable()
         .scaledToFit()
         .frame(height: 120)
      
   }
   var imageAttribution: some View {
      Text("Walking image designed by The Pyramid School from The Noun Project")
         .brandFont(size: 16, color: BrandColors.N0)
         .multilineTextAlignment(.center)
   }
}

extension LaunchScreen {
   func runStartAnimation() {
      withAnimation(.bouncy) {
         zoomTheImageMoveTheText()
         removeTheScreen()
      }
   }
   
   func zoomTheImageMoveTheText() {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
         withAnimation {
            scale = CGSize(width: 60, height: 60)
            opacity = 0
            brandLogoOffset = -UIScreen.main.bounds.height * 0.45
            brandLogoColor = BrandColors.B500
         }
      })
   }
   
   func removeTheScreen() {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.9, execute: {
         withAnimation {
            isShown = false
         }
      })
      
   }
}

#Preview {
   LaunchScreen(isShown: .constant(true))
}
