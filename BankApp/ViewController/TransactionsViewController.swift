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
    private lazy var headerView: AccountInformationView = {
        let view = AccountInformationView()
        var frame = view.frame
        frame.size.width = self.view.bounds.size.width
        frame.size.height = 185.0
        view.frame = frame
        return view
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(requestService), for: .valueChanged)
        return control
    }()
    
    private var selectedATMTransaction: (ATMLocation, TransactionViewModel)?
    
    override func configureSubviews() {
        super.configureSubviews()
        tableView.tableHeaderView = headerView
        tableView.addSubview(refreshControl)
        tableView.register(SectionHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: String(describing: SectionHeaderView.self))
    }
    
    override func configureContent() {
        super.configureContent()
        showHUD()
        requestService()
        viewModel.transactionsObservable.subscribe(onNext: { [weak self] viewModels in
            guard let `self` = self else { return }
            self.hideHUD()
            if let model = self.viewModel.account {
                self.headerView.configure(viewModel: model)
            }
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            }, onError: { [weak self] error in
                self?.showErrorMessage(title: "Error", message: error.localizedDescription)
        }).disposed(by: rx.disposeBag)
    }
    
    override func navigationTitle() -> String {
        return "Account Details"
    }
    
    override func shouldHideNavigationBar() -> Bool {
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let next = segue.destination as? MapViewController, let atmModel = selectedATMTransaction {
            next.atmLocation = atmModel.0
            next.transaction = atmModel.1
        }
    }
    
    @objc private func requestService() {
        viewModel.request()
    }
}

extension TransactionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let atmModel = viewModel.handleTapOnTransaction(at: indexPath) {
            selectedATMTransaction = atmModel
            self.performSegue(withIdentifier: "toMapView", sender: self)
        }
    }
}

extension TransactionsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: SectionHeaderView.self)) as? SectionHeaderView
        if view?.content == nil {
            let subview = TitleSubtitleView()
            view?.contentView.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
            view?.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                          options: [],
                                                          metrics: nil,
                                                          views: ["childView": subview]))
            view?.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                          options: [],
                                                          metrics: nil,
                                                          views: ["childView": subview]))
            view?.content = subview
        }
        
        if let content = view?.content as? TitleSubtitleView {
            content.configure(viewModel: viewModel.sectionHeaderModel(in: section))
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath)
        if let cell = cell as? TransactionTableViewCell, let model = viewModel.transaction(at: indexPath) {
            cell.configure(viewModel: model)
        }
        return cell
    }
}
