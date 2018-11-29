//
//  ATMLocation.swift
//  BankApp
//
//  Created by Hai Le Thanh on 11/29/18.
//  Copyright © 2018 Hai Le Thanh. All rights reserved.
//

import Foundation
import CoreLocation

struct ATMLocation: Decodable {
    let id: String
    let name: String
    let address: String
    let location: CLLocationCoordinate2D
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case location
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        address = try container.decode(String.self, forKey: .address)
        let loc = try container.decode([String: Double].self, forKey: .location)
        location = CLLocationCoordinate2D(latitude: loc["lat"] ?? 0, longitude: loc["lng"] ?? 0)
    }
}
