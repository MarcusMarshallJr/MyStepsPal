//
//  Pedometer.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import Foundation

///A simplied interface for a data source that generates pedometer data.
protocol Pedometer {
    
    ///A boolean that signals true if the current device has a pedometer; false otherwise.
   var isAvailableForDevice: Bool { get }
    
    ///A boolean that signals true if the user has given permission to use the on-device pedometer; false otherwise.
   var permissionIsAuthorizedByUser: Bool { get }
    
    ///Starts generating live pedometer data. It provides the data via an asychronously called completion handler.
   func startLivePedometerData(withHandler handler: @escaping (PedometerData?, Error?) -> Void)
    
    ///Queries for historical pedometer data within the provided starting and ending`Date` range.
   func queryPedometerData(from startDate: Date, to endDate: Date) async throws -> PedometerData
}
