//
//  UserDefaults+Extensions.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import Foundation

extension UserDefaults: UserDefaults_Protocol {
   public enum Keys {
      static let dailyStepGoal = "dailyStepGoal"
      
   }
   
   @UserDefault(key: UserDefaults.Keys.dailyStepGoal,
                defaultValue: 6000)
   static var dailyStepGoal: Int
}
