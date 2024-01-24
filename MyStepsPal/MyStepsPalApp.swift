//
//  MyStepsPalApp.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/23/24.
//

import SwiftUI

@main
struct MyStepsPalApp: App {
   
   @State private var showLaunchScreen: Bool = true
   
   var body: some Scene {
      WindowGroup {
         if showLaunchScreen {
            LaunchScreen(isShown: $showLaunchScreen)
         } else {
            HomeScreen()
         }
      }
   }
}
