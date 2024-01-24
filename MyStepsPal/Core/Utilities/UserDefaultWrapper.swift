//
//  UserDefaultWrapper.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import Foundation

///A  generic wrapper that will encode and decode values for UserDefaults
@propertyWrapper
struct UserDefault<Value> {
   
   ///The key value string to referene the user default by.
   let key: String
   
   ///The inital value of the user default.
   let defaultValue: Value
   
   ///The place where the value should be stored. By defaults values are stored in Standard UserDefaults.
   let container: UserDefaults = .standard
   
   ///
   var wrappedValue: Value {
      get {
         container.object(forKey: key) as? Value ?? defaultValue
      }
      set {
         container.set(newValue, forKey: key)
      }
   }
}
