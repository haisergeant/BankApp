//
//  Transaction.swift
//  BankApp
//
//  Created by Hai Le Thanh on 11/29/18.
//  Copyright © 2018 Hai Le Thanh. All rights reserved.
//

import Foundation

struct Transaction: Decodable {
    let id: String
    let effectiveDate: Date
    let description: String
    let amount: Double
    let atmId: String?
}
