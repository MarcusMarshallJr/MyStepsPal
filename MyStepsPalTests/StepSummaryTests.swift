//
//  StepSummaryTests.swift
//  MyStepsPalTests
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import XCTest
@testable import MyStepsPal


final class StepSummaryTests: XCTestCase {
   
   func testStepSummaryComparator_isEqualTrue() {
      var booleanResult: Bool = false
      
      //WHEN
      booleanResult = Fixtures.validStepSummary == Fixtures.validStepSummary
      
      //THEN
      XCTAssertTrue(booleanResult)
   }
   
   func testStepSummaryComparator_isEqualFalse() {
      var booleanResult: Bool = true
   
      //WHEN
      booleanResult = Fixtures.validStepSummaries[0] == Fixtures.validStepSummaries[1]
      
      //THEN
      XCTAssertFalse(booleanResult)
   }
   
   

}
