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
    
    var body: some View {
        ZStack {
            Circle()
              .stroke(BrandColors.N200, lineWidth: lineWidth)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(BrandColors.N900, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
        }.padding(lineWidth/2)
    }
}

#Preview {
    ArcProgressView(progress: 0.6)
}
