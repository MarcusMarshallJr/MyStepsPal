//
//  Fixtures.swift
//  MyStepsPalTests
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import Foundation
@testable import MyStepsPal

struct Fixtures {
   static var validPedometerData: [PedometerData] {
      return [MockPedometerData(date: try! Date("2024-01-23T00:00:00-06:00",
                                                strategy: .iso8601),
                                stepCount: 2248,
                                distanceMovedInMeters: 1544,
                                numStairsClimbed: 3),
              
              MockPedometerData(date: try! Date("2024-01-22T00:00:00-06:00",
                                                        strategy: .iso8601),
                                        stepCount: 6483,
                                        distanceMovedInMeters: 4667,
                                        numStairsClimbed: 1),
              
              MockPedometerData(date: try! Date("2024-01-21T00:00:00-06:00",
                                                        strategy: .iso8601),
                                        stepCount: 5567,
                                        distanceMovedInMeters: 3862,
                                        numStairsClimbed: 0),
              
              MockPedometerData(date: try! Date("2024-01-20T00:00:00-06:00",
                                                        strategy: .iso8601),
                                        stepCount: 13067,
                                        distanceMovedInMeters: 3862,
                                        numStairsClimbed: 1),
              
              MockPedometerData(date: try! Date("2024-01-19T00:00:00-06:00",
                                                        strategy: .iso8601),
                                        stepCount: 8117,
                                        distanceMovedInMeters: 5471,
                                        numStairsClimbed: 2),
              
              MockPedometerData(date: try! Date("2024-01-18T00:00:00-06:00",
                                                        strategy: .iso8601),
                                        stepCount: 4358,
                                        distanceMovedInMeters: 3057,
                                        numStairsClimbed: 0),
              
              MockPedometerData(date: try! Date("2024-01-17T00:00:00-06:00",
                                                        strategy: .iso8601),
                                        stepCount: 5429,
                                        distanceMovedInMeters: 3862,
                                        numStairsClimbed: 1),
      ]
   }
   
   static var validPedometerDatum: PedometerData {
      return Fixtures.validPedometerData[0]
   }
   
   static var validStepSummaries: [StepSummary] {
      return validPedometerData
         .map { StepSummary(from: $0) }
         .sorted(by: { $0.date > $1.date})
   }
   
   static var validStepSummary: StepSummary {
      return validStepSummaries[0]
   }
   
   static var january23: Date {
      return try! Date("2024-01-23T00:00:00-06:00", strategy: .iso8601)
   }
   
   static var previous6DaysBeforeJan23: [Date] {
      return [
         try! Date("2024-01-22T00:00:00-06:00", strategy: .iso8601),
         try! Date("2024-01-21T00:00:00-06:00", strategy: .iso8601),
         try! Date("2024-01-20T00:00:00-06:00", strategy: .iso8601),
         try! Date("2024-01-19T00:00:00-06:00", strategy: .iso8601),
         try! Date("2024-01-18T00:00:00-06:00", strategy: .iso8601),
         try! Date("2024-01-17T00:00:00-06:00", strategy: .iso8601),
      ]
   }
}
