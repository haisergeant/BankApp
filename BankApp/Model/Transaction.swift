//
//  Transaction.swift
//  BankApp
//
//  Created by Hai Le Thanh on 11/29/18.
//  Copyright © 2018 Hai Le Thanh. All rights reserved.
//

import Foundation

struct Transaction: Decodable, Equatable {
    let id: String
    let effectiveDate: Date
    var description: String
    let amount: Double
    let atmId: String?
    
    public static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.id == rhs.id &&
            lhs.effectiveDate == rhs.effectiveDate &&
            lhs.description == rhs.description &&
            lhs.amount == rhs.amount &&
            lhs.atmId == rhs.atmId
    }
}
