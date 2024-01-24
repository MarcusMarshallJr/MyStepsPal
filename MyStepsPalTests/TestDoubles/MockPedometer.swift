//
//  MockPedometer.swift
//  MyStepsPalTests
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import Foundation

@testable import MyStepsPal

class MockPedometer: Pedometer {
   var isAvailableForDevice: Bool = true
   var permissionIsAuthorizedByUser: Bool = true
   
   var livePedometerData_stubbed: PedometerData? = nil
   var livePedometerError_stubbed: Error? = nil
   var queriedPedometerStepCount_stubbed: Int?
   
   func startLivePedometerData(withHandler handler: @escaping (PedometerData?, Error?) -> Void) {
      handler(livePedometerData_stubbed, livePedometerError_stubbed)
   }
   func queryPedometerData(from startDate: Date, to endDate: Date) async throws -> PedometerData {
      guard let queriedPedometerStepCount_stubbed else {
         return MockPedometerData(date: startDate, stepCount: 1000)
      }
      
      return MockPedometerData(date: startDate, stepCount: queriedPedometerStepCount_stubbed)
   }
   
   
}
