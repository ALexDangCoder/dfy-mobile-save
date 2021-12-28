//
//  SharedReference.swift
//  Runner
//
//  Created by NguyenHuuNghia on 19/12/2021.
//

import Foundation

class SharedPreference {
    static let shared = SharedPreference()
    
    let userDefault = UserDefaults.standard
    
    func appLock() -> Bool {
        return userDefault.bool(forKey: "isAppLock")
    }
    
    func faceId() -> Bool {
        return userDefault.bool(forKey: "isFaceId")
    }
    
    func setConfig(isAppLock: Bool, isFaceId: Bool) {
        userDefault.set(isAppLock, forKey: "isAppLock")
        userDefault.set(isFaceId, forKey: "isFaceId")
    }
    
    func getPassword() -> String {
        let password = userDefault.string(forKey: "password")
        return password ?? ""
    }
    
    func savePassword(password: String) {
        userDefault.set(password, forKey: "password")
    }
    
    func getListWallet() -> [WalletModel] {
        let listParam = userDefault.object(forKey: "listWallet") as? [[String: Any]] ?? []
        var listWallet = [WalletModel]()
        listParam.forEach { walletParam in
            listWallet.append(WalletModel(param: walletParam))
        }
        return listWallet
    }
    
    func saveListWallet(listWallet: [WalletModel]) {
        var listParam = [[String: Any]]()
        listWallet.forEach { wallet in
            listParam.append(wallet.toDict())
        }
        userDefault.set(listParam, forKey: "listWallet")
    }
    
    func getListTokens() -> [TokenModel] {
        let listParam = userDefault.object(forKey: "listTokens") as? [[String: Any]] ?? []
        var listTokens = [TokenModel]()
        listParam.forEach { tokenParam in
            listTokens.append(TokenModel(param: tokenParam))
        }
        return listTokens
    }
    
    func saveListTokens(listTokens: [TokenModel]) {
        var listParam = [[String: Any]]()
        listTokens.forEach { tokenModel in
            listParam.append(tokenModel.toDict())
        }
        userDefault.set(listParam, forKey: "listTokens")
    }
    
    func getListNft() -> [NftModel] {
        let listParam = userDefault.object(forKey: "listNft") as? [[String: Any]] ?? []
        let listNft = listParam.map{NftModel(param: $0)}
        return listNft
    }
    
    func saveListNft(listNft: [NftModel]) {
        let listParam = listNft.map{$0.toDict()}
        userDefault.set(listParam, forKey: "listNft")
    }
    
//    func eraseWallet() {
//        userDefault.set([], forKey: "listWallet")
//    }
}
