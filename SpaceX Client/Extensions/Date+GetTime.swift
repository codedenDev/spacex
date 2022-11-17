//
//  Date+GetTime.swift
//  SpaceX Client
//
//  Created by Richard on 28/06/2022
//

import Foundation

extension Date{
    func getTime() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
    func getDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
}

extension Date {
    var daysAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 5, to: self)!
    }

    var daysBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -5, to: self)!
    }
}
