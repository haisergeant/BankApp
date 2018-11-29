//
//  Account.swift
//  BankApp
//
//  Created by Hai Le Thanh on 11/29/18.
//  Copyright © 2018 Hai Le Thanh. All rights reserved.
//

import Foundation
import CoreLocation

struct Account: Decodable {
    let accountName: String
    let accountNumber: String
    let available: Double
    let balance: Double
}
