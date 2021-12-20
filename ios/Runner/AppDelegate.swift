import UIKit
import Flutter
import WalletCore

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var chatChanel: FlutterMethodChannel?
    private let TOKEN_DFY_ADDRESS = "0x20f1dE452e9057fe863b99d33CF82DBeE0C45B14"
    private let TOKEN_BNB_ADDRESS = "0x0000000000000000000000000000000000000000"
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let chatChanel = FlutterMethodChannel(name: "flutter/trust_wallet", binaryMessenger: controller.binaryMessenger)
      chatChanel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          self.handleMethodCall(call: call, result : result)
      })
      
      self.chatChanel = chatChanel
      
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

extension AppDelegate {
    private func handleMethodCall(call: FlutterMethodCall, result: FlutterResult) {
        guard self.chatChanel != nil else { return }
//        if call.method == "getListWallets" {
//            if let arguments = call.arguments as? [String: Any], let password = arguments["password"] as? String {
//                result(getListWallet(password: password))
//            }
//        }
//        if call.method == "getPriceTokenResponse" {
//            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String {
//                result(getNFT(walletAddress: walletAddress))
//            }
//        }
//        if call.method == "getTokens" {
//            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String {
//                result(getTokens(walletAddress: walletAddress))
//            }
//        }
        if call.method == "generateWallet" {
                result(generateWallet())
        }
        if call.method == "storeWallet" {
            if let arguments = call.arguments as? [String: Any], let seedPhrase = arguments["seedPhrase"] as? String, let walletName = arguments["walletName"] as? String, let privateKey = arguments["privateKey"] as? String, let walletAddress = arguments["walletAddress"] as? String {
                result(storeWallet(seedPhrase: seedPhrase, walletName: walletName, privateKey: privateKey, walletAddress: walletAddress))
            }
        }
        if call.method == "setConfig" {
            if let arguments = call.arguments as? [String: Any], let isAppLock = arguments["isAppLock"] as? Bool, let isFaceID = arguments["isFaceID"] as? Bool {
                result(setConfig(appLock: isAppLock,faceID: isFaceID))
            }
        }
        if call.method == "savePassword" {
            if let arguments = call.arguments as? [String: Any], let password = arguments["password"] as? String {
                result(savePassword(password: password))
            }
        }
        if call.method == "getListWallets" {
            result(getListWallets())
        }
        if call.method == "importToken" {
            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String, let tokenAddress = arguments["tokenAddress"] as? String, let tokenFullName = arguments["tokenFullName"] as? String, let iconToken = arguments["iconToken"] as? String, let symbol = arguments["symbol"] as? String, let decimal = arguments["decimal"] as? Int, let exchangeRate = arguments["exchangeRate"] as? Double, let isImport = arguments["isImport"] as? Bool {
                result(importToken(walletAddress: walletAddress, tokenAddress: tokenAddress, tokenFullName: tokenFullName, iconToken: iconToken, symbol: symbol, decimal: decimal, exchangeRate: exchangeRate, isImport: isImport))
            }
        }
//        if call.method == "getTokens" {
//            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String {
//                result(getTokens(walletAddress: walletAddress))
//            }
//        }
        if call.method == "checkPassword" {
            if let arguments = call.arguments as? [String: Any], let password = arguments["password"] as? String {
                result(checkPassword(password: password))
            }
        }
        if call.method == "getConfig" {
            result(getConfigWallet())
        }
        if call.method == "changePassword" {
            if let arguments = call.arguments as? [String: Any], let oldPassword = arguments["oldPassword"] as? String, let newPassword = arguments["newPassword"] as? String {
                result(changePassWordWallet(oldPassword: oldPassword, newPassword: newPassword))
            }
        }
        if call.method == "earseWallet" {
            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String {
                result(eraseWallet(walletAddress: walletAddress))
            }
        }
        if call.method == "changeNameWallet" {
            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String, let walletName = arguments["walletName"] as? String {
                result(changeNameWallet(walletAddress: walletAddress, walletName: walletName))
            }
        }
        if call.method == "chooseWallet" {
            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String {
                result(chooseWallet(walletAddress: walletAddress))
            }
        }
        if call.method == "checkToken" {
            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String, let tokenAddress = arguments["tokenAddress"] as? String {
                result(checkToken(walletAddress: walletAddress, tokenAddress: tokenAddress))
            }
        }
        if call.method == "importListToken" {
            if let arguments = call.arguments as? [String: Any], let jsonTokens = arguments["jsonTokens"] as? String, let walletAddress = arguments["walletAddress"] as? String {
                
            }
        }
        if call.method == "setShowedToken" {
            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String, let tokenAddress = arguments["tokenAddress"] as? String, let isShow = arguments["isShow"] as? Bool, let isImport = arguments["isImport"] as? Bool {
                result(setShowedToken(walletAddress: walletAddress, tokenAddress: tokenAddress, isShow: isShow, isImport: isImport))
            }
        }
        if call.method == "importNft" {
            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String, let jsonNft = arguments["jsonNft"] as? String {
                
            }
        }
//        if call.method == "earseAllWallet" {
//            if let arguments = call.arguments as? [String: Any], let type = arguments["type"] as? String {
//                result(eraseAllWallet(type: type))
//            }
//        }
//
        result(FlutterMethodNotImplemented)
//
//
//        guard call.method == "signTransaction" else {
//            result(FlutterMethodNotImplemented)
//            return
//        }
    }
}

extension AppDelegate {
    private func checkPassword(password: String) -> [String: Any] {
        var params: [String: Any] = [:]
        params["isCorrect"] = password == SharedPreference.shared.getPassword()
        chatChanel?.invokeMethod("checkPasswordCallback", arguments: params)
        return params
    }
    
    private func generateWallet() -> [String: Any] {
        let wallet = HDWallet(strength: 128, passphrase: "")
        let seedPhrase = wallet!.mnemonic
        let address = wallet?.getAddressForCoin(coin: .smartChain)
        let walletName = "Account \(SharedPreference.shared.getListWallet().count + 1)"
        let privateKey = (wallet?.getKeyForCoin(coin: .smartChain).data)!.hexEncodedString()
        var params: [String: Any] = [:]
        params["walletName"] = walletName
        params["walletAddress"] = address
        params["privateKey"] = privateKey
        params["passPhrase"] = seedPhrase
        chatChanel?.invokeMethod("generateWalletCallback", arguments: params)
        return params
    }
    
    private func getNFT(walletAddress: String) -> [[String: Any]] {
        var params: [[String: Any]] = []
        let param1: [String: Any] = [
            "nftName": "walletName1",
            "walletAddress": "0x753EE7D5FdBD248fED37add0C951211E03a7DA15",
            "iconNFT": [],
        ]
        params.append(param1)
        let param2: [String: Any] = [
            "walletName": "walletName2",
            "walletAddress": "0x753EE7D5FdBD248fED37add0C951211E03a7DA15",
            "iconNFT": [],
        ]
        params.append(param2)
        chatChanel?.invokeMethod("getNFTCallback", arguments: params)
        return params
    }
    
    private func storeWallet(seedPhrase: String, walletName: String, privateKey: String, walletAddress: String) -> [String: Any] {
        var params: [String: Any] = [:]
        params["isSuccess"] = true
        var listWallet = [WalletModel]()
        listWallet.append(contentsOf: SharedPreference.shared.getListWallet())
        listWallet.insert(WalletModel(walletName: walletName, walletAddress: walletAddress, walletIndex: 0, seedPhrase: seedPhrase, privateKey: privateKey), at: 0)
        for (index, wallet) in listWallet.enumerated() {
            wallet.walletIndex = index
        }
        SharedPreference.shared.saveListWallet(listWallet: listWallet)
        chatChanel?.invokeMethod("storeWalletCallback", arguments: params)
        return params
    }
    
    private func setConfig(appLock: Bool, faceID: Bool) -> [String: Any] {
        var params: [String: Any] = [:]
        params["isSuccess"] = true
        SharedPreference.shared.setConfig(isAppLock: appLock, isFaceId: faceID)
        chatChanel?.invokeMethod("setConfigCallback", arguments: params)
        return params
    }
    
    private func savePassword(password: String) -> [String: Any] {
        if (!password.isEmpty) {
            var params: [String: Any] = [:]
            params["isSuccess"] = true
            SharedPreference.shared.savePassword(password: password)
            chatChanel?.invokeMethod("savePasswordCallback", arguments: params)
            return params
        }
        chatChanel?.invokeMethod("savePasswordCallback", arguments: [:])
        return [:]
    }
    
    private func getListWallets() -> [[String: Any]] {
        var listParam: [[String: Any]] = []
        SharedPreference.shared.getListWallet().forEach { walletModel in
            listParam.append(walletModel.toWalletParam())
        }
        chatChanel?.invokeMethod("getListWalletsCallback", arguments: listParam)
        return listParam
    }
    
    private func getTokens(walletAddress: String) -> [[String: Any]] {
        var listParam: [[String: Any]] = []
        chatChanel?.invokeMethod("getTokensCallback", arguments: listParam)
        return []
    }

    private func getConfigWallet() -> [String: Any] {
        var params: [String: Any] = [:]
        params["isAppLock"] = SharedPreference.shared.appLock()
        params["isFaceID"] = SharedPreference.shared.faceId()
        params["isWalletExist"] = !SharedPreference.shared.getListWallet().isEmpty
        chatChanel?.invokeMethod("getConfigCallback", arguments: params)
        return params 
    }
    
    private func changePassWordWallet(oldPassword: String, newPassword: String) -> [String: Any] {
        var params: [String: Any] = [:]
        params["isSuccess"] = oldPassword == SharedPreference.shared.getPassword()
        if SharedPreference.shared.getPassword() == oldPassword {
            SharedPreference.shared.savePassword(password: newPassword)
        }
        chatChanel?.invokeMethod("changePasswordCallback", arguments: params)
        return params
    }
    
    private func changeNameWallet(walletAddress: String, walletName: String) -> [String: Any] {
        var params: [String: Any] = [:]
        let wallet = SharedPreference.shared.getListWallet().first { $0.walletAddress == walletAddress }
        if wallet != nil && !walletName.isEmpty {
            var listWallet = [WalletModel]()
            listWallet.append(contentsOf: SharedPreference.shared.getListWallet())
            listWallet.first{ $0.walletAddress == walletAddress }?.walletName = walletName
            SharedPreference.shared.saveListWallet(listWallet: listWallet)
            params["isSuccess"] = true
        } else {
            params["false"] = true
        }
        chatChanel?.invokeMethod("changeNameWalletCallBack", arguments: params)
        return params
    }

    private func eraseWallet(walletAddress: String) -> [String: Any] {
        var params: [String: Any] = [:]
        params["isSuccess"] = true
        var listWallet = [WalletModel]()
        for (index, wallet) in SharedPreference.shared.getListWallet().enumerated() {
            if (walletAddress != wallet.walletAddress) {
                listWallet.append(wallet)
            }
        }
        SharedPreference.shared.saveListWallet(listWallet: listWallet)
        chatChanel?.invokeMethod("earseWalletCallback", arguments: params)
        return params
    }

    private func eraseAllWallet(type: String) -> [String: Any] {
        var params: [String: Any] = [:]
        params["isSuccess"] = true
        params["type"] = type
        chatChanel?.invokeMethod("earseAllWalletCallback", arguments: params)
        return params 
    }
    
    private func chooseWallet(walletAddress: String) -> [[String: Any]] {
        var listParams = [[String: Any]]()
        var listWallet = [WalletModel]()
        let listWalletInCore = SharedPreference.shared.getListWallet()
        listWalletInCore.forEach { (walletModel) in
            if (walletAddress == walletModel.walletAddress) {
                listWallet.insert(walletModel, at: 0)
            } else {
                listWallet.append(walletModel)
            }
        }
        for (index, walletModel) in listWallet.enumerated() {
            walletModel.walletIndex = index
        }
        SharedPreference.shared.saveListWallet(listWallet: listWallet)
        listWallet.forEach { walletModel in
            listParams.append(walletModel.toWalletParam())
        }
        chatChanel?.invokeMethod("chooseWalletCallBack", arguments: listParams)
        return listParams
    }
    
    private func importToken(walletAddress: String,
                             tokenAddress: String,
                             tokenFullName: String,
                             iconToken: String,
                             symbol: String,
                             decimal: Int,
                             exchangeRate: Double,
                             isImport: Bool) -> [String: Any] {
        var param = [String: Any]()
        var listTokens = [TokenModel]()
        listTokens.append(contentsOf: SharedPreference.shared.getListTokens())
        if listTokens.first(where: { $0.walletAddress == walletAddress && $0.tokenAddress == tokenAddress && $0.isShow }) == nil {
            listTokens.append(TokenModel(walletAddress: walletAddress, tokenAddress: tokenAddress, tokenFullName: tokenFullName, iconUrl: iconToken, symbol: symbol, decimal: decimal, exchangeRate: exchangeRate, isShow: true, isImport: isImport))
            SharedPreference.shared.saveListTokens(listTokens: listTokens)
            param["isSuccess"] = true
        } else {
            param["isSuccess"] = false
        }
        chatChanel?.invokeMethod("importTokenCallback", arguments: param)
        return param
    }
    
    private func checkToken(walletAddress: String, tokenAddress: String) -> [String: Any] {
        var param = [String: Any]()
        param["isExist"] = SharedPreference.shared.getListTokens().first(where: { $0.walletAddress == walletAddress && $0.tokenAddress == tokenAddress && $0.isShow }) != nil
        chatChanel?.invokeMethod("checkTokenCallback", arguments: param)
        return param
    }
    
    private func importListToken(walletAddress: String, jsonTokens: String) {
        let listAllToken = SharedPreference.shared.getListTokens()
        var listTokenAddress = listAllToken.filter {$0.walletAddress == walletAddress}
        var listTokenOther = listAllToken.filter {$0.walletAddress != walletAddress}
    }
    
    private func setShowedToken(walletAddress: String, tokenAddress: String, isShow: Bool, isImport: Bool) -> [String: Any] {
        var param = [String: Any]()
        if (tokenAddress != TOKEN_DFY_ADDRESS || tokenAddress != TOKEN_BNB_ADDRESS) {
            var listToken = [TokenModel]()
            if isImport {
                SharedPreference.shared.getListTokens().forEach { (tokenModel) in
                    if tokenModel.walletAddress != walletAddress || tokenModel.tokenAddress != tokenAddress {
                        listToken.append(tokenModel)
                    }
                }
            } else {
                listToken.append(contentsOf: SharedPreference.shared.getListTokens())
                listToken.first(where: {$0.walletAddress == walletAddress && $0.tokenAddress == tokenAddress})?.isShow = isShow
            }
            SharedPreference.shared.saveListTokens(listTokens: listToken)
            param["isSuccess"] = true
        } else {
            param["isSuccess"] = false
        }
        chatChanel?.invokeMethod("setShowedTokenCallback", arguments: param)
        return param
    }
    
    private func importNft(jsonNft: String, walletAddress: String) {
        
    }
}

extension StringProtocol {
    var data: Data { .init(utf8) }
    var bytes: [UInt8] { .init(utf8) }
}

extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return self.map { String(format: format, $0) }.joined()
    }
}
