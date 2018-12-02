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
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
    
    private(set) var accountTransaction: AccountTransaction?
    
    private(set) var account: AccountInformationViewModel?
    private var headerModels = [TitleSubtitleViewModel]()
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
                guard let `self` = self else { return }
                self.accountTransaction = accTransaction
                self.account = AccountInformationViewModel(account: accTransaction.account)
                
                // Combine the list of transactions with pending transactions
                var data = accTransaction.transactions
                let pending = accTransaction.pending.map { transaction -> Transaction in
                    Transaction(id: transaction.id,
                                effectiveDate: transaction.effectiveDate,
                                description: "<b>PENDING:</b> \(transaction.description)",
                        amount: transaction.amount,
                        atmId: transaction.atmId)
                }
                
                data.append(contentsOf: pending)
                data.sort { $0.effectiveDate > $1.effectiveDate }
                
                // Transform to viewModels
                let transformData = data.compactMap { TransactionViewModel(transaction: $0) }
                
                // Group and sort viewModels by effectiveDate
                let dictionary = Dictionary(grouping: transformData, by: { $0.date })
                let groupedList = dictionary.values
                var list = groupedList.sorted { $0[0].date > $1[0].date }
                
                
                list.insert([self.estimateExpenses2Weeks(from: data)], at: 0)
                list.forEach { [weak self] array in
                    if let `self` = self, let firstItem = array.first {
                        let date = firstItem.date
                        self.headerModels.append(TitleSubtitleViewModel(title: self.dateFormatter.string(from: date),
                                                                        subtitle: date.numberOfDaysSinceNow()))
                    }
                }
                
                self.transactions.onNext(list)
        }, onError: { [weak self] error in
            self?.transactions.onError(error)
        }).disposed(by: disposeBag)
    }
    
    private func estimateExpenses2Weeks(from list: [Transaction]) -> TransactionViewModel {
        var totalEachFornight = [Double]()
        var totalExpenses: Double = 0.0
        var firstItem: Transaction?
        for item in list {
            if firstItem == nil {
                firstItem = item
            } else if let dayNum = firstItem?.effectiveDate.numberOfDaysSince(date: item.effectiveDate), abs(dayNum) > 14 {
                totalEachFornight.append(totalExpenses)
                firstItem = item
                totalExpenses = 0.0
            } else if item.amount < 0 {
                totalExpenses += item.amount
            }
            if let last = list.last, item == last {
                totalEachFornight.append(totalExpenses)
            }
        }
        
        let total = totalEachFornight.reduce(0, +)

        return TransactionViewModel(title: "Estimate expenses next fornight", amount: total / Double(totalEachFornight.count))
        
    }
    
    func numberOfSection() -> Int {
        return groupedTransactions.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        return groupedTransactions[section].count
    }
    
    func sectionHeaderModel(in section: Int) -> TitleSubtitleViewModel {
        return headerModels[section]
    }
    
    func transaction(at indexPath: IndexPath) -> TransactionViewModel? {
        return groupedTransactions[indexPath.section][indexPath.row]
    }
    
    func handleTapOnTransaction(at indexPath: IndexPath) -> (atm: ATMLocation, transaction: TransactionViewModel)? {
        if let atm = accountTransaction,
            let model = transaction(at: indexPath),
            let atmId = model.transaction?.atmId,
            let firstATM = atm.atms.first(where: { $0.id == atmId }) {
            return (atm: firstATM, transaction: model)
        }
        return nil
    }
}
