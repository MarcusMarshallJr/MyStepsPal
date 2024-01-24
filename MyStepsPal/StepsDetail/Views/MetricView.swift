//
//  MetricView.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import SwiftUI

struct MetricView: View {
   
   let value: String
   let title: String
   var style: MetricStyle = .subtle
   
    var body: some View {
       switch style {
       case .subtle:
          subtleMetricView
       case .prominent:
          promientMetricView
       }
    }
}

//MARK: - Views
extension MetricView {
   var subtleMetricView: some View {
      VStack(alignment: .leading) {
         Text(title.uppercased())
            .brandSubtleOverline()
         Text(value)
            .brandSubtleNumber()
      }
   }
   
   var promientMetricView: some View {
      VStack(alignment: .leading) {
         Text(value)
            .brandProminentNumber()
         Text(title.uppercased())
            .brandSubtleOverline()
      }
   }

}

#Preview {
   MetricView(value: "2.5 mi", 
              title: "distance", 
              style: .prominent)
}
