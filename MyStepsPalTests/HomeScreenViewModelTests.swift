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
   var mockUserDefaults: MockUserDefaults.Type!
   var subject: HomeScreenViewModel!
   
   override func setUpWithError() throws {
      super.setUp()
      mockPedometerService = MockPedometerService()
      mockUserDefaults = MockUserDefaults.self
      subject = HomeScreenViewModel(pedometerService: mockPedometerService,
                                    userDefaults: mockUserDefaults)
   }
   override func tearDownWithError() throws {
      subject = nil
      mockUserDefaults.resetMockToDefaultValues()
      try super.tearDownWithError()
   }
   
   
   //MARK: - Test Initalization State and Reset State
   func testViewModel_startsWithZerosAndNils() {
      XCTAssertEqual(subject.todaysStepSummary.stepCount, 0)
      XCTAssertEqual(subject.stepHistory.count, 0)
      XCTAssertNil(subject.error)
      XCTAssertFalse(subject.presentStepGoalSheet)
      XCTAssertEqual(subject.dailyStepGoal, mockUserDefaults.dailyStepGoal)
   }
   func testResetUI_zerosAndNilsEveythingOut() {
      //WHEN
      subject.resetUI()
      
      //THEN
      XCTAssertEqual(subject.todaysStepSummary.stepCount, 0)
      XCTAssertEqual(subject.stepHistory.count, 0)
      XCTAssertNil(subject.error)
      XCTAssertFalse(subject.presentStepGoalSheet)
      XCTAssertEqual(subject.dailyStepGoal, mockUserDefaults.dailyStepGoal)
   }
   
   
   //MARK: - Test Computed Properties
   func testTodayProgress_generatesCorrectDouble() async {
      //GIVEN
      mockPedometerService.livePedometerData_stubbed = Fixtures.validPedometerDatum
      let expectedProgress = Double(Fixtures.validPedometerDatum.stepCount) / Double(mockUserDefaults.dailyStepGoal)
      
      //WHEN
      await subject.startDataRetrival()
      
      //THEN
      XCTAssertEqual(subject.todaysProgress, expectedProgress)
   }
   func testTodayProgressPercentage_generatesCorrectString() async {
      //GIVEN
      mockPedometerService.livePedometerData_stubbed = Fixtures.validPedometerDatum
      let expectedProgressString = "45%"
      
      //WHEN
      await subject.startDataRetrival()
      
      //THEN
      XCTAssertEqual(subject.todaysProgressPercentage, expectedProgressString)
   }
   
   
   //MARK: - Test User Interaction Functions
   func testHandleChangeGoalTapped() {
      //WHEN
      subject.handleChangeGoalTapped()
      
      //THEN
      XCTAssertTrue(subject.presentStepGoalSheet)
   }
   func testHandleChangeGoalDismissed() {
      //WHEN
      subject.handleChangeGoalDismissed()
      
      //THEN
      XCTAssertFalse(subject.presentStepGoalSheet)
   }
   func testHandleChangeGoalConfirmed_updatesUserDefaults() {
      //GIVEN
      let newGoal = mockUserDefaults.dailyStepGoal + 1000
      
      //WHEN
      subject.handleChangeGoalConfirmed(newGoal: newGoal)
      
      //THEN
      XCTAssertEqual(newGoal, mockUserDefaults.dailyStepGoal)
   }
   
   
   //MARK: - Test startDataRetrival
   func testStartDataRetrival_stepCountingUnavailable_signalsError() async {
      //GIVEN
      mockPedometerService.pedometerIsAvailableForDevice = false
      
      //WHEN
      await subject.startDataRetrival()
      
      //THEN
      XCTAssertEqual(subject.error, PedometerError.stepCountingUnavailable.rawValue)
   }
   func testStartDataRetrival_permissionDenied_signalsError() async {
      //GIVEN
      mockPedometerService.pedometerPermissionIsAuthorizedByUser = false
      
      //WHEN
      await subject.startDataRetrival()
      
      //THEN
      XCTAssertEqual(subject.error, PedometerError.stepCountingPermissionDenied.rawValue)
   }
   func testStartDataRetrival_setsStepSummaryForCurrentDay() async {
      
      //GIVEN
      var todaysStepSummary: StepSummary?
      mockPedometerService.livePedometerData_stubbed = Fixtures.validPedometerDatum
      let matchingStepSummary = Fixtures.validStepSummary
      
      //WHEN
      await subject.startDataRetrival()
      todaysStepSummary = subject.todaysStepSummary
      
      XCTAssertNotNil(todaysStepSummary)
      XCTAssertEqual(todaysStepSummary, matchingStepSummary)
   }
   func testStartDataRetrival_setsStepHistory() async {
      
      //GIVEN
      var historicalStepData: [StepSummary]?
      mockPedometerService.historicalPedometerData_stubbed = Fixtures.validPedometerData
      let matchingReverseChronologicalStepSummaries =  Fixtures.validStepSummaries
      
      //WHEN
      await subject.startDataRetrival()
      historicalStepData = subject.stepHistory
      
      //THEN
      XCTAssertNotNil(historicalStepData)
      XCTAssertEqual(historicalStepData, matchingReverseChronologicalStepSummaries)
   }
   func testStartDataRetrival_hasReverseChronologicalStepHistory() async {
      //GIVEN
      var historicalStepData: [StepSummary]?
      mockPedometerService.historicalPedometerData_stubbed = Fixtures.validPedometerData
      
      //WHEN
      await subject.startDataRetrival()
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

