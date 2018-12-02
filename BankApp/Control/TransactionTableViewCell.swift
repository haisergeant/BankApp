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
    var transaction: Transaction?
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
    
    init(title: String, amount: Double, style: Style = Style()) {
        self.title = title.styled(with: style.titleStyle)
        self.amount = String(format: "$%.2f", fabs(amount)).styled(with: style.amountStyle)
    }
    
    var date: Date {
        return transaction?.effectiveDate ?? Date()
    }
}

class TransactionTableViewCell: BaseTableViewCell {
    
    @IBOutlet private weak var pinImgView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet weak var pinWidth: NSLayoutConstraint!
    @IBOutlet weak var pinAndTitleSpacing: NSLayoutConstraint!
    
    func configure(viewModel: TransactionViewModel) {
        titleLabel.attributedText = viewModel.title
        amountLabel.attributedText = viewModel.amount
        
        amountLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        pinImgView.isHidden = viewModel.transaction?.atmId == nil
        pinWidth.constant = viewModel.transaction?.atmId == nil ? 0 : 45
        pinAndTitleSpacing.constant = viewModel.transaction?.atmId == nil ? 0 : 10
            
        
    }
}
