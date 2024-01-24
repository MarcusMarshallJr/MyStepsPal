//
//  StepSummaryTests.swift
//  MyStepsPalTests
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import XCTest
@testable import MyStepsPal


final class StepSummaryTests: XCTestCase {
   
   //MARK: - Test stepGoalStatus
   func testStepGoalStatus_generatesExceededStatus() {
      //GIVEN
      var goalStatus: GoalStatus?
      let stepSummary = Fixtures.validStepSummary
      let goal = stepSummary.stepCount - 1
      
      //WHEN
      goalStatus = stepSummary.stepGoalStatus(given: goal)
      
      //THEN
      XCTAssertNotNil(goalStatus)
      XCTAssertEqual(goalStatus, .exceeded)
   }
   
   func testStepGoalStatus_generatesMetStatus() {
      //GIVEN
      var goalStatus: GoalStatus?
      let stepSummary = Fixtures.validStepSummary
      let goal = stepSummary.stepCount
      
      //WHEN
      goalStatus = stepSummary.stepGoalStatus(given: goal)
      
      //THEN
      XCTAssertNotNil(goalStatus)
      XCTAssertEqual(goalStatus, .met)
   }
   
   func testStepGoalStatus_generatesBelowStatus() {
      //GIVEN
      var goalStatus: GoalStatus?
      let stepSummary = Fixtures.validStepSummary
      let goal = stepSummary.stepCount + 1
      
      //WHEN
      goalStatus = stepSummary.stepGoalStatus(given: goal)
      
      //THEN
      XCTAssertNotNil(goalStatus)
      XCTAssertEqual(goalStatus, .below)
   }
   
   
   //MARK: - Test Step Summary Comparator
   func testStepSummaryComparator_isEqualTrue() {
      //GIVEN
      var booleanResult: Bool = false
      
      //WHEN
      booleanResult = Fixtures.validStepSummary == Fixtures.validStepSummary
      
      //THEN
      XCTAssertTrue(booleanResult)
   }
   
   func testStepSummaryComparator_isEqualFalse() {
      //GIVEN
      var booleanResult: Bool = true
      
      //WHEN
      booleanResult = Fixtures.validStepSummaries[0] == Fixtures.validStepSummaries[1]
      
      //THEN
      XCTAssertFalse(booleanResult)
   }
   
   
}
