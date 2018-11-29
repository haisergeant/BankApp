//
//  BaseViewController.swift
//  EventsApp
//
//  Created by Hai Le on 8/10/18.
//  Copyright © 2018 Hai Le. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {
    
    private lazy var hud = MBProgressHUD.showAdded(to: self.view, animated: true)
    
    init() {
        super.init(nibName: nil, bundle: nil)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TO BE OVERRIDE
    func initialize() { }
    func navigationTitle() -> String { return "" }
    func backgroundColor() -> UIColor { return .white }
    func shouldHideNavigationBar() -> Bool { return true }
    func configureSubviews() { }
    func configureLayout() { }
    func configureContent() { }
    func configureStyle() { }
    func configureActions() { }
    
    func showHUD() {        
        hud.show(animated: true)
    }
    
    func hideHUD() {
        hud.hide(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = navigationTitle()
        self.view.backgroundColor = backgroundColor()
        configureSubviews()
        configureLayout()
        configureContent()
        configureStyle()
        configureActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(shouldHideNavigationBar(), animated: false)
    }
    
    func showErrorMessage(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { (action) in
            completion?()
        })
        self.present(alertController, animated: true, completion: nil)
    }
}
