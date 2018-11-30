//
//  ServerRepository.swift
//  BankApp
//
//  Created by Hai Le Thanh on 11/29/18.
//  Copyright © 2018 Hai Le Thanh. All rights reserved.
//

import Foundation
import RxSwift

struct AccountTransaction: Decodable {
    let account: Account
    let transactions: [Transaction]
    let pending: [Transaction]
    let atms: [ATMLocation]
}

class ServerRepository: Repository {
    private let defaultSession = URLSession(configuration: .default)
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    private var dataTask: URLSessionDataTask?
    
    func retrieveTransaction(from urlString: String) -> Observable<AccountTransaction> {
        return Observable.create { [weak self] observer -> Disposable in
            guard let `self` = self else { return Disposables.create() }
            if let url = URL(string: urlString) {
                self.dataTask = self.defaultSession.dataTask(with: url) { data, response, error in
                    DispatchQueue.main.async {
                        do {
                            if let error = error {
                                observer.onError(error)
                            } else if let data = data {
                                var accTransaction = try self.decoder.decode(AccountTransaction.self, from: data)
                                observer.onNext(accTransaction)
                            }
                        } catch {
                            observer.onError(error)
                        }
                    }
                }
                self.dataTask?.resume()
            }
            return Disposables.create()
        }
    }
}
