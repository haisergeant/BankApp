//
//  BaseTableViewCell.swift
//  EventsApp
//
//  Created by Hai Le Thanh on 10/9/18.
//  Copyright © 2018 Hai Le. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
        configureLayout()
        configureContent()
        configureStyle()
        configureActions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureSubviews()
        configureLayout()
        configureContent()
        configureStyle()
        configureActions()
    }
    
    func configureSubviews() { }
    func configureLayout() { }
    func configureContent() { }
    func configureStyle() { }
    func configureActions() { }

}
