//
//  TransactionsViewController.swift
//  BankApp
//
//  Created by Hai Le Thanh on 11/29/18.
//  Copyright © 2018 Hai Le Thanh. All rights reserved.
//

import UIKit
import NSObject_Rx

class TransactionsViewController: BaseViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = TransactionsViewModel()
    private let headerView = AccountInformationView().loadNib()
    
    override func configureSubviews() {
        super.configureSubviews()
        tableView.tableHeaderView = headerView
    }
    
    override func configureContent() {
        super.configureContent()
        viewModel.request()
        viewModel.transactionsObservable.subscribe(onNext: { [weak self] viewModels in
            self?.tableView.reloadData()
            
            }, onError: { [weak self] error in
                self?.showErrorMessage(title: "Error", message: error.localizedDescription)
        }).disposed(by: rx.disposeBag)
    }
    
    override func navigationTitle() -> String {
        return "Account Details"
    }
}

extension TransactionsViewController: UITableViewDelegate {
    
}

extension TransactionsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath)
        if let cell = cell as? TransactionTableViewCell {
            
        }
        return cell
    }
}
