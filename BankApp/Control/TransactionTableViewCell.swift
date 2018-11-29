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
    }
    
    
}

class TransactionTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    func configure(viewModel: TransactionViewModel) {
        
    }
}
