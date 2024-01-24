//
//  SimulatorPedometerTests.swift
//  MyStepsPalTests
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import XCTest
@testable import MyStepsPal

final class SimulatorPedometerTests: XCTestCase {
   
   var simulatorPedometer: SimulatorPedometer!
   
   
   //MARK: - Setup and Tear Down
   override func setUpWithError() throws {
      try super.setUpWithError()
      simulatorPedometer = SimulatorPedometer()
   }
   override func tearDownWithError() throws {
      simulatorPedometer = nil
      try super.tearDownWithError()
   }
   
   
   //MARK: - Test Inital State
   func testPedometer_isAlwaysAvailable() {
      XCTAssertTrue(simulatorPedometer.isAvailableForDevice)
   }
   func testPedometer_alwaysHasPermission() {
      XCTAssertTrue(simulatorPedometer.permissionIsAuthorizedByUser)
   }
   
   
   //MARK: - Test Provides Data
   func testStartLivePedometerData_providesData() {
      
      var simulatedData: PedometerData?
      let simulatedDataProvided = expectation(description: "Some simulated data is provided from callback")
      
      simulatorPedometer.startLivePedometerData { pedometerData, error in
         
         simulatedData = pedometerData
         simulatedDataProvided.fulfill()
      }
      
      wait(for: [simulatedDataProvided], timeout: 1)
      XCTAssertNotNil(simulatedData)
   }
   func testQueryPedometerData_providesData() async throws {
      
      var simulatedData: PedometerData?
      
      let now = Date()
      simulatedData = try await simulatorPedometer.queryPedometerData(from: Date.startOfToday, to: now)
      
      XCTAssertNotNil(simulatedData)
   }
}
