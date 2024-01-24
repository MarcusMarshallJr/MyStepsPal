//
//  HomeScreenViewModelTests.swift
//  MyStepsPalTests
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import XCTest
@testable import MyStepsPal

final class HomeScreenViewModelTests: XCTestCase {
   
   var mockPedometerService: MockPedometerService!
   var subject: HomeScreenViewModel!
   
   override func setUpWithError() throws {
      super.setUp()
      mockPedometerService = MockPedometerService()
      subject = HomeScreenViewModel(pedometerService: mockPedometerService)
   }
   override func tearDownWithError() throws {
      subject = nil
      try super.tearDownWithError()
   }
   
   func testViewModel_startsWithZeroStepCount() {
      XCTAssertEqual(subject.todaysStepSummary.stepCount, 0)
   }
   
   func testStartLiveStepData_stepCountingUnavailable_signalsError() {
      //GIVEN
      mockPedometerService.pedometerIsAvailableForDevice = false
      
      //WHEN
      subject.startLiveStepData()
      
      //THEN
      XCTAssertEqual(subject.error, PedometerError.stepCountingUnavailable.rawValue)
   }
   func testStartLiveStepData_permissionDenied_signalsError() {
      //GIVEN
      mockPedometerService.pedometerPermissionIsAuthorizedByUser = false
      
      //WHEN
      subject.startLiveStepData()
      
      //THEN
      XCTAssertEqual(subject.error, PedometerError.stepCountingPermissionDenied.rawValue)
   }
   func testGetLivePedometerData_mapsPedometerDataToStepSummary() {
      
      //GIVEN
      var todaysStepSummary: StepSummary?
      mockPedometerService.livePedometerData_stubbed = Fixtures.validPedometerDatum
      let matchingStepSummary = Fixtures.validStepSummary
      
      //WHEN
      subject.startLiveStepData()
      todaysStepSummary = subject.todaysStepSummary
      
      XCTAssertNotNil(todaysStepSummary)
      XCTAssertEqual(todaysStepSummary, matchingStepSummary)
   }
   
   func testGetHistoricalStepData_stepCountingUnavailable_signalsError() async {
      //GIVEN
      mockPedometerService.pedometerIsAvailableForDevice = false
      
      //WHEN
      await subject.getHistoricalStepData()
      
      //THEN
      XCTAssertEqual(subject.error, PedometerError.stepCountingUnavailable.rawValue)
   }
   func testGetHistoricalStepData_permissionDenied_signalsError() async {
      //GIVEN
      mockPedometerService.pedometerPermissionIsAuthorizedByUser = false
      
      //WHEN
      await subject.getHistoricalStepData()
      
      //THEN
      XCTAssertEqual(subject.error, PedometerError.stepCountingPermissionDenied.rawValue)
   }
   func testGetHistoricalStepData_mapsPedometerDataToStepSummaries() async {

      //GIVEN
      var historicalStepData: [StepSummary]?
      mockPedometerService.historicalPedometerData_stubbed = Fixtures.validPedometerData
      let matchingReverseChronologicalStepSummaries =  Fixtures.validStepSummaries
      
      //WHEN
      await subject.getHistoricalStepData()
      historicalStepData = subject.stepHistory
      
      //THEN
      XCTAssertNotNil(historicalStepData)
      XCTAssertEqual(historicalStepData, matchingReverseChronologicalStepSummaries)
   }
   
   func testGetHistoricalStepData_hasReverseChronologicalStepHistory() async {
      //GIVEN
      var historicalStepData: [StepSummary]?
      mockPedometerService.historicalPedometerData_stubbed = Fixtures.validPedometerData
      
      //WHEN
      await subject.getHistoricalStepData()
      historicalStepData = subject.stepHistory
      
      XCTAssertNotNil(historicalStepData)
      
      //THEN
      for index in 0..<historicalStepData!.count {
         let nextIndex = index + 1
         if nextIndex < historicalStepData!.count {
            XCTAssertLessThan(historicalStepData![nextIndex].date, historicalStepData![index].date)

         }
      }
   }
   

   
   
   
   
   
}

