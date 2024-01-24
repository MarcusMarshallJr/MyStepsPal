//
//  ArcProgressView.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import SwiftUI

struct ArcProgressView: View {
   let progress: Double
   var lineWidth: Double = 20
   var progressRingColor: Color = BrandColors.B500
   var backgroundRingColor: Color = BrandColors.B200
   
   var body: some View {
      ZStack {
         Circle()
            .stroke(backgroundRingColor, lineWidth: lineWidth)
         Circle()
            .trim(from: 0, to: progress)
            .stroke(progressRingColor, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
         
            .rotationEffect(.degrees(-90))
            .animation(.easeOut, value: progress)
      }.padding(lineWidth/2)
   }
}

#Preview {
   ArcProgressView(progress: 0.6)
}
