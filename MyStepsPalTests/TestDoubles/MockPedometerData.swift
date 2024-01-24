//
//  MockPedometerData.swift
//  MyStepsPalTests
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import Foundation

@testable import MyStepsPal

struct MockPedometerData: PedometerData {
   var date: Date
   var stepCount: Int
   var distanceMovedInMeters: Double?
   var numStairsClimbed: Int?
}
