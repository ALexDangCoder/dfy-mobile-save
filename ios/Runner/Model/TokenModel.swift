//
//  TokenModel.swift
//  Runner
//
//  Created by NguyenHuuNghia on 20/12/2021.
//

import Foundation

struct TokenDTO: Decodable {
    var walletAddress: String?
    var tokenAddress: String?
    var nameToken: String?
    var iconToken: String?
    var nameShortToken: String?
    var decimal: Int?
    var exchangeRate: Double?
    var isImport: Bool?
}

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
    
    init(param: [String: Any]) {
        self.walletAddress = param["walletAddress"] as! String
        self.tokenAddress = param["tokenAddress"] as! String
        self.tokenFullName = param["tokenFullName"] as! String
        self.iconUrl = param["iconUrl"] as! String
        self.symbol = param["symbol"] as! String
        self.decimal = param["decimal"] as! Int
        self.exchangeRate = param["exchangeRate"] as! Double
        self.isShow = param["isShow"] as! Bool
        self.isImport = param["isImport"] as! Bool
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
