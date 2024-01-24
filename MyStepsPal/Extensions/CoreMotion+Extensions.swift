//
//  CMPedometer+Extensions.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import CoreMotion

//Conforms CMPedometer to Data Source Protocol
extension CMPedometer: Pedometer {
   var isAvailableForDevice: Bool {
      return CMPedometer.isStepCountingAvailable()
   }
   var permissionIsAuthorizedByUser: Bool {
      return CMPedometer.authorizationStatus() == .authorized
      || CMPedometer.authorizationStatus() == .notDetermined
      
   }
   
   func startLivePedometerData(withHandler: @escaping (PedometerData?, Error?) -> Void) {
      self.startUpdates(from: Date.startOfToday) { pedometerData, error in
         withHandler(pedometerData, error)
      }
   }
   func queryPedometerData(from startDate: Date, to endDate: Date) async throws -> PedometerData {
      
      return try await withCheckedThrowingContinuation { continuation in
         self.queryPedometerData(from: startDate, to: endDate) { pedometerData, error in
            guard error == nil else {
               continuation.resume(throwing: error!)
               return
            }
            
            guard let pedometerData else {
               continuation.resume(throwing: PedometerError.pedometerDataNil)
               return
            }
            
            continuation.resume(returning: pedometerData)
         }
      }
   }
}

extension CMPedometerData: PedometerData {
   var date: Date {
      self.startDate
   }
   var stepCount: Int {
      return self.numberOfSteps.intValue
   }
   var distanceMovedInMeters: Double? {
      return self.distance?.doubleValue
   }
   var numStairsClimbed: Int? {
      return self.floorsAscended?.intValue
   }
}

