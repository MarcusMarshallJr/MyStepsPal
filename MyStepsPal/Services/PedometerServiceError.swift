//
//  PedometerServiceError.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import Foundation

///A set of errors specific to an object that provides pedometer related data
enum PedometerServiceError: String, Error {
    
   case stepCountingUnavailable = "Step Counting is not available on this device."
   case stepCountingAuthorizationUndetermined = "User has not indicated authorization status of pedometer data."
   case stepCountingPermissionDenied = "User has denied use of pedometer data."
   case pedometerDataNil = "Pedometer data object returned nil"
}
