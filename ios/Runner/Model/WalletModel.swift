//
//  WalletModel.swift
//  Runner
//
//  Created by NguyenHuuNghia on 19/12/2021.
//

import Foundation

class WalletModel {
    var walletName = ""
    var walletAddress = ""
    var walletIndex = 0
    var seedPhrase = ""
    var privateKey = ""
    var isImportWallet = false
    
    init(walletName: String, walletAddress: String, walletIndex: Int, seedPhrase: String, privateKey: String, isImportWallet: Bool = false) {
        self.walletName = walletName
        self.walletAddress = walletAddress
        self.walletIndex = walletIndex
        self.seedPhrase = seedPhrase
        self.privateKey = privateKey
        self.isImportWallet = isImportWallet
    }
    
    init(param: [String: Any]) {
        self.walletName = param["walletName"] as! String
        self.walletAddress = param["walletAddress"] as! String
        self.walletIndex = param["walletIndex"] as! Int
        self.seedPhrase = param["seedPhrase"] as! String
        self.privateKey = param["privateKey"] as! String
        self.isImportWallet = param["isImportWallet"] as! Bool
    }
    
    func toDict() -> [String: Any] {
        return [
            "walletName": walletName,
            "walletAddress": walletAddress,
            "walletIndex": walletIndex,
            "seedPhrase": seedPhrase,
            "privateKey": privateKey,
            "isImportWallet": isImportWallet,
        ]
    }
    
    func toWalletParam() -> [String: Any] {
        return [
            "walletName": walletName,
            "walletAddress": walletAddress,
            "isImportWallet": isImportWallet,
        ]
    }
}
