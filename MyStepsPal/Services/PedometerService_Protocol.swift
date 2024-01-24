//
//  PedometerService_Protocol.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import Foundation

/// A simple interface for a model object that retrieves pedometer data from some data source that can generate it.
protocol PedometerService_Protocol {
   
   ///Requests that underling pedometer to begin generating live data. It provides the data via an asychronously called completion handler.
   func startLivePedometerData(withHandler: @escaping (PedometerData?, Error?) -> Void) throws
   
   ///Retrieves 6 days of historical pedometer data from the underling pedometer
   func retrieveSixDayHistoricalPedometerData() async throws -> [PedometerData]
}
