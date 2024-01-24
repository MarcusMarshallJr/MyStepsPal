//
//  UserDefaultWrapper.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import Foundation

@propertyWrapper
struct UserDefault<Value> {
   let key: String
   let defaultValue: Value
   let container: UserDefaults = .standard
   
   var wrappedValue: Value {
      get {
         container.object(forKey: key) as? Value ?? defaultValue
      }
      set {
         container.set(newValue, forKey: key)
      }
   }
}
