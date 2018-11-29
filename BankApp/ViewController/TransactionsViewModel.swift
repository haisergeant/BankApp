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
    
    
    
    func request() {
        repository.retrieveTransaction(from: AppConstant.transactionUrl)
            .subscribe(onNext: { [weak self] accTransaction in
                
                
            
        }, onError: { [weak self] error in
            
        }).disposed(by: disposeBag)
    }
}
