//
//  TokenModel.swift
//  Runner
//
//  Created by NguyenHuuNghia on 20/12/2021.
//

import Foundation

class TokenModel {
    var walletAddress = ""
    var tokenAddress = ""
    var tokenFullName = ""
    var iconUrl = ""
    var symbol = ""
    var decimal = 0
    var exchangeRate = 0.0
    var isShow = false
    var isImport = false
    
    init(walletAddress: String, tokenAddress: String, tokenFullName: String, iconUrl: String, symbol: String, decimal: Int, exchangeRate: Double, isShow: Bool, isImport: Bool) {
        self.walletAddress = walletAddress
        self.tokenAddress = tokenAddress
        self.tokenFullName = tokenFullName
        self.iconUrl = iconUrl
        self.symbol = symbol
        self.decimal = decimal
        self.exchangeRate = exchangeRate
        self.isShow = isShow
        self.isImport = isImport
    }
    
    func toDict() -> [String: Any] {
        return [
            "walletAddress": walletAddress,
            "tokenAddress": tokenAddress,
            "tokenFullName": tokenFullName,
            "iconUrl": iconUrl,
            "symbol": symbol,
            "decimal": decimal,
            "exchangeRate": exchangeRate,
            "isShow": isShow,
            "isImport": isImport,
        ]
    }
}
