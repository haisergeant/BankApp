//
//  AccountInformationView.swift
//  BankApp
//
//  Created by Hai Le Thanh on 11/29/18.
//  Copyright © 2018 Hai Le Thanh. All rights reserved.
//

import UIKit
import BonMot

struct AccountInformationViewModel {
    let account: Account
    
    let accountName: NSAttributedString
    let accountNumber: NSAttributedString
    
    let availableFund: NSAttributedString
    let accountBalance: NSAttributedString
    
    let fundAmount: NSAttributedString
    let balanceAmount: NSAttributedString
    
    struct Style {
        let accountNameStyle: StringStyle
        let accountNumberStyle: StringStyle
        
        let availableFundStyle: StringStyle
        let accountBalanceStyle: StringStyle
        
        let fundAmountStyle: StringStyle
        let balanceAmountStyle: StringStyle
        init(accountNameStyle: StringStyle = AccountViewStyle.accountNameStyle,
             accountNumberStyle: StringStyle = AccountViewStyle.accountNumberStyle,
             availableFundStyle: StringStyle = AccountViewStyle.availableFundStyle,
             accountBalanceStyle: StringStyle = AccountViewStyle.accountBalanceStyle,
             fundAmountStyle: StringStyle = AccountViewStyle.fundAmountStyle,
             balanceAmountStyle: StringStyle = AccountViewStyle.balanceAmountStyle) {
            self.accountNameStyle = accountNameStyle
            self.accountNumberStyle = accountNumberStyle
            self.availableFundStyle = availableFundStyle
            self.accountBalanceStyle = accountBalanceStyle
            self.fundAmountStyle = fundAmountStyle
            self.balanceAmountStyle = balanceAmountStyle
        }
    }
    
    init(account: Account, style: Style = Style()) {
        self.account = account
        accountName = account.accountName.styled(with: style.accountNameStyle)
        accountNumber = account.accountNumber.styled(with: style.accountNumberStyle)
        
        availableFund = "Available funds".styled(with: style.availableFundStyle)
        accountBalance = "Account balance".styled(with: style.accountBalanceStyle)
        
        fundAmount = String(format: "$%.2f", account.available).styled(with: style.fundAmountStyle)
        balanceAmount = String(format: "%.2f", account.balance).styled(with: style.balanceAmountStyle)
    }
}

class AccountInformationView: NibView {
    @IBOutlet private weak var accountLabel: UILabel!
    @IBOutlet private weak var accountNumberLabel: UILabel!
    
    @IBOutlet private weak var availabelFundLabel: UILabel!
    @IBOutlet private weak var accountBalanceLabel: UILabel!
    
    @IBOutlet private weak var fundAmountLabel: UILabel!
    @IBOutlet private weak var balanceAmountLabel: UILabel!
    
    func configure(viewModel: AccountInformationViewModel) {
        accountLabel.attributedText = viewModel.accountName
        accountNumberLabel.attributedText = viewModel.accountNumber
        
        availabelFundLabel.attributedText = viewModel.availableFund
        accountBalanceLabel.attributedText = viewModel.accountBalance
        
        fundAmountLabel.attributedText = viewModel.fundAmount
        balanceAmountLabel.attributedText = viewModel.balanceAmount
    }
}
