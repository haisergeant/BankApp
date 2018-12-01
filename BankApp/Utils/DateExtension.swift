//
//  DateExtension.swift
//  BankApp
//
//  Created by Hai Le Thanh on 12/1/18.
//  Copyright © 2018 Hai Le Thanh. All rights reserved.
//

import Foundation

extension Date {
    func numberOfDaysSinceNow() -> String {
        let days = Calendar.current.dateComponents([.day], from: self, to: Date()).day
        if let days = days {
            switch days {
            case 1:
                return "Yesterday"
            default:
                return "\(days) Days Ago"
            }
        } else {
            return ""
        }
    }
}
