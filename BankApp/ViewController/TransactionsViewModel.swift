//
//  TransactionsViewModel.swift
//  BankApp
//
//  Created by Hai Le Thanh on 11/29/18.
//  Copyright © 2018 Hai Le Thanh. All rights reserved.
//

import Foundation
import RxSwift

class TransactionsViewModel {
    private let repository: Repository = ServerRepository()
    private let disposeBag = DisposeBag()
    
    
    private(set) var accountTransaction: AccountTransaction?
    
    private(set) var account: AccountInformationViewModel?
    
    private let transactions = BehaviorSubject<[TransactionViewModel]>(value: [TransactionViewModel]())
    var transactionsObservable: Observable<[TransactionViewModel]> {
        return transactions.asObservable()
    }
    
    func request() {
        repository.retrieveTransaction(from: AppConstant.transactionUrl)
            .subscribe(onNext: { [weak self] accTransaction in
                self?.accountTransaction = accTransaction
                self?.account = AccountInformationViewModel(account: accTransaction.account)
                self?.transactions.onNext(accTransaction.transactions.compactMap { TransactionViewModel(transaction: $0) })
        }, onError: { [weak self] error in
            self?.transactions.onError(error)
        }).disposed(by: disposeBag)
    }
    
    func numberOfSection() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        do {
            return try transactions.value().count
        } catch {
            return 0
        }
    }
    
    func transaction(at index: Int) -> TransactionViewModel? {
        do {
            return try transactions.value()[index]
        } catch {
            return nil
        }
    }
}
