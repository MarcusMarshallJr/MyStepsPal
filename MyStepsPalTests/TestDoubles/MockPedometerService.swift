//
//  MockPedometerService.swift
//  MyStepsPalTests
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import Foundation
@testable import MyStepsPal

class MockPedometerService: PedometerService_Protocol {
   var pedometerIsAvailableForDevice: Bool = true
   var pedometerPermissionIsAuthorizedByUser: Bool = true
   
   var historicalPedometerData_stubbed: [PedometerData] = []
   var livePedometerData_stubbed: PedometerData? = nil
   var livePedometerError_stubed: Error? = nil
   
   func startLivePedometerData(withHandler handler: @escaping (PedometerData?, Error?) -> Void) throws {
      
      guard pedometerIsAvailableForDevice else {
         throw PedometerError.stepCountingUnavailable
      }
      
      guard pedometerPermissionIsAuthorizedByUser else {
         throw PedometerError.stepCountingPermissionDenied
      }
      
      handler(livePedometerData_stubbed, livePedometerError_stubed)
   }
   func retrieveSixDayHistoricalPedometerData() async throws -> [PedometerData] {
      guard pedometerIsAvailableForDevice else {
         throw PedometerError.stepCountingUnavailable
      }
      
      guard pedometerPermissionIsAuthorizedByUser else {
         throw PedometerError.stepCountingPermissionDenied
      }
      
      return historicalPedometerData_stubbed
   }
   
}
