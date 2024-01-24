//
//  Date+ExtensionsTests.swift
//  MyStepsPalTests
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import XCTest

@testable import MyStepsPal

final class Date_ExtensionsTests: XCTestCase {
   
   func testShortDate_generatesCorrectString() {
      //GIVEN
      let expectedShortDate = "1/23/24"
      let dateObject = Fixtures.january23
      let shortDate: String
      
      //WHEN
      shortDate = dateObject.shortDate
      
      //THEN
      XCTAssertEqual(shortDate, expectedShortDate)
   }
   
   func testLongDate_generatesCorrectString() {
      //GIVEN
      let expectedLongDate = "January 23, 2024"
      let dateObject = Fixtures.january23
      let longDate: String
      
      //WHEN
      longDate = dateObject.longDate
      
      //THEN
      XCTAssertEqual(longDate, expectedLongDate)
   }
   
   func testDayString_generatesCorrectString() {
      //GIVEN
      let expectedDayString = "Tuesday"
      let dateObject = Fixtures.january23
      let dayString: String
      
      //WHEN
      dayString = dateObject.dayString
      
      //THEN
      if Calendar.current.isDateInToday(dateObject) {
         XCTAssertEqual(dayString, "Today")
      } else if Calendar.current.isDateInYesterday(dateObject) {
         XCTAssertEqual(dayString, "Yesterday")
      } else {
         XCTAssertEqual(dayString, expectedDayString)
      }
   }
   
   func testGetPrevious_6Days() {
      let previous6Days = Date.getPrevious(nDays: 6, before: Fixtures.january23)
      
      XCTAssertEqual(previous6Days, Fixtures.previous6DaysBeforeJan23)
   }
   
   func testGetPrevious_NoDays() {
      let previousDays = Date.getPrevious(nDays: 0)
      
      XCTAssertEqual(previousDays, [])
      
   }
   
}
