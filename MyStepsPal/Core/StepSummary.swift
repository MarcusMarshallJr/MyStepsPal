//
//  StepSummary.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import Foundation

struct StepSummary: Identifiable {
   let id: UUID = UUID()
   let date: Date
   let stepCount: Int
   let distanceInMiles: Double?
   let numStairsClimbed: Int?
   
//MARK: - Initalization
   init(date: Date,
        stepCount: Int,
        distanceInMiles: Double? = nil,
        stairsClimbed: Int? = nil) {
      self.date = date
      self.stepCount = stepCount
      self.distanceInMiles = distanceInMiles
      self.numStairsClimbed = stairsClimbed
   }
   
   init(from pedometerData: PedometerData) {
      self.date = pedometerData.date
      self.stepCount = pedometerData.stepCount
      
      if let distanceInMeters = pedometerData.distanceMovedInMeters {
         let distanceMeasurement = Measurement(value: distanceInMeters,
                                               unit: UnitLength.meters)
         
         self.distanceInMiles = distanceMeasurement.converted(to: .miles).value
      } else {
         self.distanceInMiles = nil
      }
   
      self.numStairsClimbed = pedometerData.numStairsClimbed
   }
   
   
   //MARK: - Functions
   ///Generates a `Goal Status` based on this summary's step count in relation to a specified goal
   func stepGoalStatus(given goal: Int) -> GoalStatus {
      if stepCount > goal {
         return .exceeded
      } else if stepCount == goal {
         return .met
      }
      
      return .below
   }
}

extension StepSummary: Equatable {
   static func ==(lhs: StepSummary, rhs: StepSummary) -> Bool {
      return lhs.date == rhs.date
      && lhs.stepCount == rhs.stepCount
      && lhs.distanceInMiles == rhs.distanceInMiles
      && lhs.numStairsClimbed == rhs.numStairsClimbed
   }
}
