//
//  PedometerService.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import Foundation
import CoreMotion

/// A concrete implementation of the `PedometerService_Protocol` that uses `CMPedometer` or a `SimulatedPedometer` as its data source depending on the run enviornment.
class PedometerService: PedometerService_Protocol {
   
    //MARK: - Properties
    ///The pedometer data source that generates data for the service
   var pedometer: Pedometer
   
    
    //MARK: - Initalization
   init(pedometer: Pedometer = PedometerService.pedometerFactory) {
      self.pedometer = pedometer
   }
   
    
    //MARK: - Functions
    ///Requests that underling pedometer to begin generating live data, checking first, to ensure theres an available pedometer and it has permission to use it. Then, it provides the data via an asychronously called completion handler.
   func startLivePedometerData(withHandler handler: @escaping (PedometerData?, Error?) -> Void) throws {
      
      guard pedometer.isAvailableForDevice else {
         throw PedometerError.stepCountingUnavailable
      }
      
      guard pedometer.permissionIsAuthorizedByUser else {
         throw PedometerError.stepCountingPermissionDenied
      }
      
      pedometer.startLivePedometerData(withHandler: handler)
   }
   
   ///Retrieves 6 days of historical pedometer data from the underling pedometer, checking first to ensure theres an available pedometer and it has permission to use it.
   func retrieveSixDayHistoricalPedometerData() async throws -> [PedometerData] {
      guard pedometer.isAvailableForDevice else {
         throw PedometerError.stepCountingUnavailable
      }
      
      guard pedometer.permissionIsAuthorizedByUser else {
         throw PedometerError.stepCountingPermissionDenied
      }
      
      let previous6Days = Date.getPrevious(nDays: 6)
      let previous6Days_chronologicalOrder = [Date](previous6Days.reversed())
      
      var historicalData: [PedometerData] = []
      
      for (index, date) in previous6Days_chronologicalOrder.enumerated() {
         
         let startDate = date
         let nextIndex = index + 1
         let now = Date()
         let endDate = nextIndex < previous6Days_chronologicalOrder.count ? previous6Days_chronologicalOrder[nextIndex] : now
         
         let pedometerData = try await pedometer.queryPedometerData(from: startDate, to: endDate)
         
         historicalData.append(pedometerData)
      }
      
      return historicalData
   }
}


//MARK: - Static Properties
extension PedometerService {
    /// A factory that provides the appropriate pedometer given the run enviornment
   static var pedometerFactory: Pedometer {
      #if targetEnvironment(simulator)

         return SimulatorPedometer()
      #else
      
         return CMPedometer()
      #endif
   }
}
