//
//  Helpers.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import Foundation

///Runs the passed in block of code on the main thread. Used mainly to ensure code runs smoothly on both on-device and during testing
func guaranteeThisRunsOnMainThread(_ blockToRun: @escaping () -> Void) {
   if Thread.isMainThread {
      blockToRun()
   } else {
      DispatchQueue.main.async(execute: blockToRun)
   }
}
