//
//  Repository.swift
//  BankApp
//
//  Created by Hai Le Thanh on 11/29/18.
//  Copyright © 2018 Hai Le Thanh. All rights reserved.
//

import Foundation
import RxSwift

protocol Repository {
    func retrieveTransaction(from urlString: String) -> Observable<AccountTransaction>
}
