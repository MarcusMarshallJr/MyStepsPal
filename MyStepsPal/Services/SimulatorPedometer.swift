//
//  SimulatorPedometer.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import Foundation

///A concrete implementation of a `Pedometer` that simulates data when run on an iOS Simulator
struct SimulatorPedometer: Pedometer {
   
   //MARK: - Properties
   var isAvailableForDevice: Bool = true
   var permissionIsAuthorizedByUser: Bool = true
   
   
   //MARK: - Functions
   func startLivePedometerData(withHandler handler: @escaping (PedometerData?, Error?) -> Void) {
      let data = SimulatedPedometerData(date: Date.startOfToday,
                                        stepCount: 732,
                                        distanceMovedInMeters: 490,
                                        numStairsClimbed: 0)
      
      handler(data, nil)
   }
   
   func queryPedometerData(from startDate: Date, to endDate: Date) async throws -> PedometerData {
      let randomStepCount = Int.random(in: 600...10_000)
      
      let typicalSridePerStepInMeters = 0.67
      let estimatedDistanceInMeters = Double(randomStepCount) * typicalSridePerStepInMeters
      let randomNumStairsClimbed = Int.random(in: 0...5)
      
      return SimulatedPedometerData(date: startDate,
                                    stepCount: randomStepCount,
                                    distanceMovedInMeters: estimatedDistanceInMeters,
                                    numStairsClimbed: randomNumStairsClimbed)
   }
}

//MARK: - Extensions
extension SimulatorPedometer {
   struct SimulatedPedometerData: PedometerData, Codable {
      var date: Date
      var stepCount: Int
      var distanceMovedInMeters: Double?
      var numStairsClimbed: Int?
   }
}
