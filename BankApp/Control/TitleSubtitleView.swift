//
//  LeftTitleRightSubtitleView.swift
//  BankApp
//
//  Created by Hai Le Thanh on 12/1/18.
//  Copyright © 2018 Hai Le Thanh. All rights reserved.
//

import UIKit
import BonMot

struct TitleSubtitleViewModel {
    let title: NSAttributedString
    let subtitle: NSAttributedString
    
    struct Style {
        let titleStyle: StringStyle
        let subtitleStyle: StringStyle
        
        init(titleStyle: StringStyle = TransactionHeaderStyle.titleStyle,
             subtitleStyle: StringStyle = TransactionHeaderStyle.subtitleStyle) {
            self.titleStyle = titleStyle
            self.subtitleStyle = subtitleStyle
        }
    }
    
    init(title: String, subtitle: String, style: Style = Style()) {
        self.title = title.styled(with: style.titleStyle)
        self.subtitle = subtitle.styled(with: style.subtitleStyle)
    }
}

class SectionHeaderView: UITableViewHeaderFooterView {
    weak var content: UIView?
}

class TitleSubtitleView: NibView {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    func configure(viewModel: TitleSubtitleViewModel) {
        titleLabel.attributedText = viewModel.title
        subtitleLabel.attributedText = viewModel.subtitle
    }
}
