//
//  MockUserDefaults.swift
//  MyStepsPalTests
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import Foundation
@testable import MyStepsPal

class MockUserDefaults: UserDefaults_Protocol {
   static var dailyStepGoal: Int = 5000
   
   static func resetMockToDefaultValues() {
      dailyStepGoal = 5000
   }
   
}
