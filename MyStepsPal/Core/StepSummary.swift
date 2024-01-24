//
//  StepSummary.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import Foundation

///A reusable ViewModel Object that encapsulates and summarizes important step related data.
struct StepSummary: Identifiable {
   
   ///A unique identifier for the `Step Summary`
   let id: UUID = UUID()
   
   ///A timestamp that denotes the start of the day that the summary represents
   let date: Date
   
   ///The total steps taken during the`date`
   let stepCount: Int
   
   ///The total distance moved in miles during the `date`
   let distanceInMiles: Double?
   
   ///The total number of stairs climbed during the `date`
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
   ///Generates a `Goal Status`enum  based on this summary's step count in relation to a specified goal
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
