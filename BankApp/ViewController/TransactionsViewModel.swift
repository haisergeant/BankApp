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
    
    private let transactions = BehaviorSubject<[[TransactionViewModel]]>(value: [[TransactionViewModel]]())
    var transactionsObservable: Observable<[[TransactionViewModel]]> {
        return transactions.asObservable()
    }
    
    var groupedTransactions: [[TransactionViewModel]] {
        do {
            return try transactions.value()
        } catch {
            return [[TransactionViewModel]]()
        }
    }
    
    func request() {
        repository.retrieveTransaction(from: AppConstant.transactionUrl)
            .subscribe(onNext: { [weak self] accTransaction in
                self?.accountTransaction = accTransaction
                self?.account = AccountInformationViewModel(account: accTransaction.account)
                
                var data = accTransaction.transactions
                data.append(contentsOf: accTransaction.pending)
                data.sort { $0.effectiveDate < $1.effectiveDate }
                
                let transformData = data.compactMap { TransactionViewModel(transaction: $0) }
                
                let dictionary = Dictionary(grouping: transformData, by: { $0.transaction.effectiveDate })
                let groupedList = dictionary.values
                let list = groupedList.sorted { $0[0].transaction.effectiveDate < $1[0].transaction.effectiveDate }
                self?.transactions.onNext(list)
        }, onError: { [weak self] error in
            self?.transactions.onError(error)
        }).disposed(by: disposeBag)
    }
    
    func numberOfSection() -> Int {
        return groupedTransactions.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        return groupedTransactions[section].count
    }
    
    func transaction(at indexPath: IndexPath) -> TransactionViewModel? {
        return groupedTransactions[indexPath.section][indexPath.row]
    }
    
    func handleTapOnTransaction(at indexPath: IndexPath) -> (atm: ATMLocation, transaction: TransactionViewModel)? {
        if let atm = accountTransaction,
            let model = transaction(at: indexPath),
            let atmId = model.transaction.atmId,
            let firstATM = atm.atms.first(where: { $0.id == atmId }) {
            return (atm: firstATM, transaction: model)
        }
        return nil
    }
}
