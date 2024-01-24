//
//  Date+Extensions.swift
//  MyStepsPal
//
//  Created by Marcus Marshall, Jr on 1/24/24.
//

import Foundation

extension Date {
   
   ///Returns the first moment of the user's current calendar date
   static var startOfToday: Date {
      let now = Date()
      return Calendar.current.startOfDay(for: now)
   }
   
   ///Returns an array of the last n `Date` objects before the provided starting starting date, not including the starting date. By default, it will return the last n `Date` objects starting from the user's current calendar date.
   static func getPrevious(nDays: Int,
                           before startingDate: Date = startOfToday) -> [Date] {
      
      guard nDays >= 1 else { return [] }
      
      let calendar = Calendar.current
      var lastNDays: [Date] = []
      var date = startingDate
      
      for _ in 1...nDays {
         guard let previousDay = calendar.date(byAdding: .day,
                                               value: -1,
                                               to: date)
         else { return [] }
         
         lastNDays.append(previousDay)
         date = previousDay
      }
      return lastNDays
   }
}
