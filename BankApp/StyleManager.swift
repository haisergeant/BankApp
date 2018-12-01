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
    
    static let lightFontName = "HelveticaNeue-Light"
    let regularLightFont = UIFont(name: StyleManager.lightFontName, size: 16.0) ?? UIFont.systemFont(ofSize: 16.0)
    let largeLightFont = UIFont(name: StyleManager.lightFontName, size: 18.0) ?? UIFont.systemFont(ofSize: 18.0)
    
    static let regularFontName = "HelveticaNeue"
    let regularFont = UIFont(name: StyleManager.regularFontName, size: 16.0) ?? UIFont.systemFont(ofSize: 16.0)
    
    static let boldFontName = "HelveticaNeue-Bold"
    let boldFont = UIFont(name: StyleManager.boldFontName, size: 16.0) ?? UIFont.boldSystemFont(ofSize: 16.0)
    
    let marbleColor = UIColor(red: 146.0 / 255.0, green: 176.0 / 255.0, blue: 176.0 / 255.0, alpha: 1.0)
    
    let blackColor = UIColor(red: 35.0 / 255.0, green: 31.0 / 255.0, blue: 32.0 / 255.0, alpha: 1.0)
    let greyColor = UIColor(red: 138.0 / 255.0, green: 138.0 / 255.0, blue: 138.0 / 255.0, alpha: 1.0)
    let lightGreyColor = UIColor(red: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
    
    let yellowColor = UIColor(red: 255.0 / 255.0, green: 204.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)

    func boldFontStyle() -> StringStyle {
        return StringStyle(.font(StyleManager.shared.boldFont),
                           .color(StyleManager.shared.blackColor))
    }
}

struct TransactionStyle {
    static let titleStyle = StringStyle(.font(StyleManager.shared.regularFont),
                                        .color(StyleManager.shared.blackColor),
                                        .xmlRules([
                                            .style("bold", StyleManager.shared.boldFontStyle()),
                                            .style("b", StyleManager.shared.boldFontStyle())]))
    
    static let amountStyle = StringStyle(.font(StyleManager.shared.boldFont),
                                         .color(StyleManager.shared.blackColor))
}

struct TransactionHeaderStyle {
    static let titleStyle = StringStyle(.font(StyleManager.shared.boldFont),
                                        .color(StyleManager.shared.blackColor))
    static let subtitleStyle = StringStyle(.font(StyleManager.shared.boldFont),
                                         .color(StyleManager.shared.blackColor))
}

struct AccountViewStyle {
    static let accountNameStyle = StringStyle(.font(StyleManager.shared.largeLightFont),
                                              .color(StyleManager.shared.blackColor))
    static let accountNumberStyle = StringStyle(.font(StyleManager.shared.regularLightFont),
                                              .color(StyleManager.shared.greyColor))
    static let availableFundStyle = StringStyle(.font(StyleManager.shared.regularLightFont),
                                              .color(StyleManager.shared.greyColor))
    static let accountBalanceStyle = StringStyle(.font(StyleManager.shared.regularLightFont),
                                              .color(StyleManager.shared.greyColor))
    static let fundAmountStyle = StringStyle(.font(StyleManager.shared.boldFont),
                                              .color(StyleManager.shared.blackColor))
    static let balanceAmountStyle = StringStyle(.font(StyleManager.shared.boldFont),
                                              .color(StyleManager.shared.greyColor))
}
