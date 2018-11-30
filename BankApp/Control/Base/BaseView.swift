//
//  BaseView.swift
//  EventsApp
//
//  Created by Hai Le on 9/10/18.
//  Copyright © 2018 Hai Le. All rights reserved.
//

import UIKit

class BaseView: UIView {
    init() {
        super.init(frame: .zero)        
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
