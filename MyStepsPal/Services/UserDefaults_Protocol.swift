//
//  UserDefaults_Protocol.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import Foundation

///A protocol that matches keys in the `UserDefualtsWrapper` to properties any Mock must implement
protocol UserDefaults_Protocol {
   static var dailyStepGoal: Int { get set }
   
}
