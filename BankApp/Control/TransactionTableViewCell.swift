//
//  TransactionTableViewCell.swift
//  BankApp
//
//  Created by Hai Le Thanh on 11/29/18.
//  Copyright © 2018 Hai Le Thanh. All rights reserved.
//

import UIKit
import BonMot

struct TransactionViewModel {
    let transaction: Transaction
    let title: NSAttributedString
    let amount: NSAttributedString
    
    struct Style {
        let titleStyle: StringStyle
        let amountStyle: StringStyle
        init(titleStyle: StringStyle = TransactionStyle.titleStyle,
             amountStyle: StringStyle = TransactionStyle.amountStyle) {
            self.titleStyle = titleStyle
            self.amountStyle = amountStyle
        }
    }
    
    init(transaction: Transaction, style: Style = Style()) {
        self.transaction = transaction
        let description = transaction.description.replacingOccurrences(of: "<br/>", with: "\n")        
        title = description.styled(with: style.titleStyle)
        amount = String(format: transaction.amount > 0 ? "$%.2f" : "-$%.2f" , abs(transaction.amount))
            .styled(with: style.amountStyle)
    }
}

class TransactionTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    func configure(viewModel: TransactionViewModel) {
        titleLabel.attributedText = viewModel.title
        amountLabel.attributedText = viewModel.amount
        
        amountLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
}
