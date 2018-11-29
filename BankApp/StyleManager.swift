//
//  StyleManager.swift
//  BankApp
//
//  Created by Hai Le Thanh on 11/29/18.
//  Copyright © 2018 Hai Le Thanh. All rights reserved.
//

import UIKit
import BonMot

struct StyleManager {
    static let shared = StyleManager()
    
    let lightFontName = "HelveticaNeue-Light"
    let regularLightFont = UIFont(name: StyleManager.shared.lightFontName, size: 16.0)
    let largeLightFont = UIFont(name: StyleManager.shared.lightFontName, size: 18.0)
    
    let regularFontName = "HelveticaNeue"
    let boldFontName = "HelveticaNeue-Bold"
    
    let marbleColor = UIColor(red: 146.0 / 255.0, green: 176.0 / 255.0, blue: 176.0 / 255.0, alpha: 1.0)
    
    let blackColor = UIColor(red: 35.0 / 255.0, green: 31.0 / 255.0, blue: 32.0 / 255.0, alpha: 1.0)
    let greyColor = UIColor(red: 138.0 / 255.0, green: 138.0 / 255.0, blue: 138.0 / 255.0, alpha: 1.0)
    let lightGreyColor = UIColor(red: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
    
    let yellowColor = UIColor(red: 255.0 / 255.0, green: 204.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)

    
}
