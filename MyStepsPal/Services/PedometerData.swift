//
//  PedometerData.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import Foundation

///A simplfied interface to model raw data generated from a `Pedometer`.
protocol PedometerData {
   
   ///A timestamp that denotes the start of the day that the data was generated
   var date: Date { get }
   
   ///The total steps taken during the stored `date`
   var stepCount: Int { get }
   
   ///The total distance moved in meters during the stored `date`
   var distanceMovedInMeters: Double? { get }
   
   ///The total number of stairs climbed during the stored `date`
   var numStairsClimbed: Int? { get }
}
