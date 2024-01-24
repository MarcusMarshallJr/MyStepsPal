//
//  Date+ExtensionsTests.swift
//  MyStepsPalTests
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import XCTest

@testable import MyStepsPal

final class Date_ExtensionsTests: XCTestCase {

    func testGetPrevious_6Days() {
       let previous6Days = Date.getPrevious(nDays: 6, before: Fixtures.january23)
       
       XCTAssertEqual(previous6Days, Fixtures.previous6DaysBeforeJan23)
    }
    
    func testGetPrevious_NoDays() {
       let previousDays = Date.getPrevious(nDays: 0)
       
       XCTAssertEqual(previousDays, [])
       
    }

}
