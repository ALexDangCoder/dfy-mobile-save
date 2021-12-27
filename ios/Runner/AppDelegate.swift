import UIKit
import Flutter
import WalletCore
import BigInt

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var chatChanel: FlutterMethodChannel?
    
    private let TYPE_WALLET_SEED_PHRASE = "PASS_PHRASE"
    private let TYPE_WALLET_PRIVATE_KEY = "PRIVATE_KEY"
    
    private let TOKEN_DFY_ADDRESS = "0x20f1dE452e9057fe863b99d33CF82DBeE0C45B14"
    private let TOKEN_BNB_ADDRESS = "0x0000000000000000000000000000000000000000"
    
    private let TYPE_EARSE_WALLET = "earse_wallet"
    
    private let CODE_SUCCESS = 200
    private let CODE_ERROR = 400
    private let CODE_ERROR_DUPLICATE = 401
    private let CODE_ERROR_WALLET = 402
    
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
        if call.method == "getNFT" {
            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String {
                result(getNFT(walletAddress: walletAddress))
            }
        }
        if call.method == "signTransactionToken" {
            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String, let toAddress = arguments["toAddress"] as? String, let tokenAddress = arguments["tokenAddress"] as? String, let nonce = arguments["nonce"] as? String, let chainId = arguments["chainId"] as? String, let gasPrice = arguments["gasPrice"] as? String, let gasLimit = arguments["gasLimit"] as? String, let amount = arguments["amount"] as? String {
                result(signTransactionToken(walletAddress: walletAddress, tokenAddress: tokenAddress, toAddress: toAddress, nonce: nonce, chainId: chainId, gasPrice: gasPrice, gasLimit: gasLimit, amount: amount))
            }
        }
        if call.method == "getTokens" {
            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String {
                result(getTokens(walletAddress: walletAddress))
            }
        }
        if call.method == "generateWallet" {
            if let arguments = call.arguments as? [String: Any] {
                let typeEarseWallet = arguments["typeEarseWallet"] as? String ?? ""
                result(generateWallet(typeEarseWallet: typeEarseWallet))
            }
        }
        if call.method == "storeWallet" {
            if let arguments = call.arguments as? [String: Any], let seedPhrase = arguments["seedPhrase"] as? String, let walletName = arguments["walletName"] as? String, let privateKey = arguments["privateKey"] as? String, let walletAddress = arguments["walletAddress"] as? String {
                let typeEarseWallet = arguments["typeEarseWallet"] as? String ?? ""
                result(storeWallet(seedPhrase: seedPhrase, walletName: walletName, privateKey: privateKey, walletAddress: walletAddress, typeEarseWallet: typeEarseWallet))
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
                result(importListToken(walletAddress: walletAddress, jsonTokens: jsonTokens))
            }
        }
        if call.method == "setShowedToken" {
            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String, let tokenAddress = arguments["tokenAddress"] as? String, let isShow = arguments["isShow"] as? Bool, let isImport = arguments["isImport"] as? Bool {
                result(setShowedToken(walletAddress: walletAddress, tokenAddress: tokenAddress, isShow: isShow, isImport: isImport))
            }
        }
        if call.method == "importNft" {
            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String, let jsonNft = arguments["jsonNft"] as? String {
                result(importNft(jsonNft: jsonNft, walletAddress: walletAddress))
            }
        }
        if call.method == "exportWallet" {
            if let arguments = call.arguments as? [String: Any], let password = arguments["password"] as? String, let walletAddress = arguments["walletAddress"] as? String {
                result(exportWallet(password: password, walletAddress: walletAddress))
            }
        }
        if call.method == "importWallet" {
            if let arguments = call.arguments as? [String: Any], let type = arguments["type"] as? String, let content = arguments["content"] as? String {
                let typeEarseWallet = arguments["typeEarseWallet"] as? String ?? ""
                result(importWallet(type: type, content: content, typeEarseWallet: typeEarseWallet))
            }
        }
        if call.method == "deleteNft" {
            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String, let collectionAddress = arguments["collectionAddress"] as? String, let nftId = arguments["nftId"] as? String {
                result(deleteNft(walletAddress: walletAddress, collectionAddress: collectionAddress, nftId: nftId))
            }
        }
        if call.method == "deleteCollection" {
            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String, let collectionAddress = arguments["collectionAddress"] as? String {
                result(deleteCollection(walletAddress: walletAddress, collectionAddress: collectionAddress))
            }
        }
//        if call.method == "earseAllWallet" {
//            if let arguments = call.arguments as? [String: Any], let type = arguments["type"] as? String {
//                result(eraseAllWallet(type: type))
//            }
//        }
        if call.method == "signTransactionNft" {
            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String, let toAddress = arguments["toAddress"] as? String, let tokenAddress = arguments["tokenAddress"] as? String, let nonce = arguments["nonce"] as? String, let chainId = arguments["chainId"] as? String, let gasPrice = arguments["gasPrice"] as? String, let gasLimit = arguments["gasLimit"] as? String, let tokenId = arguments["tokenId"] as? String {
                result(signTransactionNft(walletAddress: walletAddress, tokenAddress: tokenAddress, toAddress: toAddress, nonce: nonce, chainId: chainId, gasPrice: gasPrice, gasLimit: gasLimit, tokenId: tokenId))
            }
        }
        
        result(FlutterMethodNotImplemented)
    }
}

extension AppDelegate {
    private func checkPassword(password: String) -> [String: Any] {
        var params: [String: Any] = [:]
        params["isCorrect"] = password == SharedPreference.shared.getPassword()
        chatChanel?.invokeMethod("checkPasswordCallback", arguments: params)
        return params
    }
    
    private func generateWallet(typeEarseWallet: String) -> [String: Any] {
        let wallet = HDWallet(strength: 128, passphrase: "")
        let seedPhrase = wallet!.mnemonic
        let address = wallet?.getAddressForCoin(coin: .smartChain)
        let walletName = (typeEarseWallet != TYPE_EARSE_WALLET) ? "Account \(SharedPreference.shared.getListWallet().count + 1)" : "Account 1"
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
        SharedPreference.shared.getListNft().forEach { nftModel in
            if (nftModel.walletAddress == walletAddress) {
                var nftParam = [String: Any]()
                nftParam["walletAddress"] = nftModel.walletAddress
                nftParam["collectionAddress"] = nftModel.collectionAddress
                nftParam["nftName"] = nftModel.nftName
                nftParam["symbol"] = nftModel.symbol
                var listNftParams = [[String: Any]]()
                nftModel.item.forEach { nftItemModel in
                    var dataListNft = [String: Any]()
                    dataListNft["id"] = nftItemModel.id
                    dataListNft["contract"] = nftItemModel.contract
                    dataListNft["uri"] = nftItemModel.uri
                    listNftParams.append(dataListNft)
                }
                nftParam["listNft"] = listNftParams
                params.append(nftParam)
            }
        }
        chatChanel?.invokeMethod("getNFTCallback", arguments: params)
        return params
    }
    
    private func storeWallet(seedPhrase: String, walletName: String, privateKey: String, walletAddress: String, typeEarseWallet: String) -> [String: Any] {
        var params: [String: Any] = [:]
        params["isSuccess"] = true
        var listWallet = [WalletModel]()
        if (typeEarseWallet != TYPE_EARSE_WALLET) {
            listWallet.append(contentsOf: SharedPreference.shared.getListWallet())
        }
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
        SharedPreference.shared.getListTokens().forEach { tokenModel in
            if tokenModel.walletAddress == walletAddress {
                listParam.append(tokenModel.toDict())
            }
        }
        chatChanel?.invokeMethod("getTokensCallback", arguments: listParam)
        return listParam
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

//    private func eraseAllWallet(type: String) -> [String: Any] {
//        var params: [String: Any] = [:]
//        params["isSuccess"] = true
//        params["type"] = type
//        SharedPreference.shared.eraseWallet()
//        chatChanel?.invokeMethod("earseAllWalletCallback", arguments: params)
//        return params 
//    }
    
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
    
    private func importListToken(walletAddress: String, jsonTokens: String) -> [String: Any] {
        let listAllToken = SharedPreference.shared.getListTokens()
        let listTokenAddress = listAllToken.filter {$0.walletAddress == walletAddress}
        let listTokenOther = listAllToken.filter {$0.walletAddress != walletAddress}
        
        var listTokens = [TokenModel]()
        let jsonData = jsonTokens.data(using: .utf8)
        let listObjectTokens = try! JSONDecoder().decode([TokenDTO].self, from: jsonData!)
        var index = 0
        while (index < listObjectTokens.count) {
            let data = listObjectTokens[index]
            let tokenAddress = data.tokenAddress ?? ""
            let tokenModel = TokenModel(walletAddress: data.walletAddress ?? "", tokenAddress: data.tokenAddress ?? "", tokenFullName: data.nameToken ?? "", iconUrl: data.iconToken ?? "", symbol: data.nameShortToken ?? "", decimal: data.decimal ?? 0, exchangeRate: data.exchangeRate ?? 0.0, isShow: tokenAddress == TOKEN_BNB_ADDRESS || tokenAddress == TOKEN_DFY_ADDRESS, isImport: data.isImport ?? false)
            let tokenInCore = listTokenAddress.first(where: {$0.tokenAddress == tokenModel.tokenAddress})
            if let token = tokenInCore {
                tokenModel.isShow = token.isShow
            }
            switch tokenAddress {
            case TOKEN_DFY_ADDRESS:
                listTokens.insert(tokenModel, at: 0)
            case TOKEN_BNB_ADDRESS:
                listTokens.insert(tokenModel, at: 1)
            default:
                listTokens.append(tokenModel)
            }
            index+=1
        }
        var param = [String: Any]()
        listTokenAddress.forEach { (tokenModel) in
            let item = listTokens.first(where: {$0.tokenAddress == tokenModel.tokenAddress})
            if item == nil {
                listTokens.append(tokenModel)
            }
        }
        listTokens.append(contentsOf: listTokenOther)
        SharedPreference.shared.saveListTokens(listTokens: listTokens)
        param["isSuccess"] = true
        chatChanel?.invokeMethod("importListTokenCallback", arguments: param)
        return param
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
    
    private func exportWallet(password: String, walletAddress: String) -> [String: Any] {
        if (password == SharedPreference.shared.getPassword()) {
            var param = [String: Any]()
            SharedPreference.shared.getListWallet().forEach { walletModel in
                if walletModel.walletAddress == walletAddress {
                    param = [
                        "walletAddress": walletModel.walletAddress,
                        "privateKey": walletModel.privateKey,
                        "passPhrase": walletModel.seedPhrase,
                    ]
                }
            }
            chatChanel?.invokeMethod("exportWalletCallBack", arguments: param)
            return param
        }
        return [:]
    }
    
    private func importWallet(type: String, content: String, typeEarseWallet: String) -> [String: Any] {
        var param = [String: Any]()
        switch type {
        case self.TYPE_WALLET_SEED_PHRASE:
            let wallet = HDWallet(mnemonic: content, passphrase: "")
            if let wallet = wallet {
                let address = wallet.getAddressForCoin(coin: .smartChain)
                let privateKey = (wallet.getKeyForCoin(coin: .smartChain).data).hexEncodedString()
                var listWallet = [WalletModel]()
                if (typeEarseWallet != TYPE_EARSE_WALLET) {
                    listWallet.append(contentsOf: SharedPreference.shared.getListWallet())
                }
                if (listWallet.first(where: {$0.walletAddress == address}) == nil) {
                    let walletName = "Account \(listWallet.count + 1)"
                    param["walletAddress"] = address
                    listWallet.insert(WalletModel(walletName: walletName, walletAddress: address, walletIndex: 0, seedPhrase: content, privateKey: privateKey, isImportWallet: true), at: 0)
                    for (index, walletModel) in listWallet.enumerated() {
                        walletModel.walletIndex  = index
                    }
                    SharedPreference.shared.saveListWallet(listWallet: listWallet)
                    param["walletName"] = walletName
                    param["code"] = CODE_SUCCESS
                    chatChanel?.invokeMethod("importWalletCallback", arguments: param)
                    return param
                } else {
                    param["walletAddress"] = ""
                    param["walletName"] = ""
                    param["code"] = CODE_ERROR_DUPLICATE
                    chatChanel?.invokeMethod("importWalletCallback", arguments: param)
                    return param
                }
            } else {
                param["walletAddress"] = ""
                param["walletName"] = ""
                param["code"] = CODE_ERROR_WALLET
                chatChanel?.invokeMethod("importWalletCallback", arguments: param)
                return param
            }
        case self.TYPE_WALLET_PRIVATE_KEY:
            if let privateKeyData = content.hexadecimal {
                let privateKey = PrivateKey(data: privateKeyData)
                if let privKey = privateKey {
                    let publicKey = privKey.getPublicKeySecp256k1(compressed: false)
                    let address = AnyAddress(publicKey: publicKey, coin: .smartChain)
                    var listWallet = [WalletModel]()
                    if (typeEarseWallet != TYPE_EARSE_WALLET) {
                        listWallet.append(contentsOf: SharedPreference.shared.getListWallet())
                    }
                    if (listWallet.first(where: {$0.walletAddress == "\(address)"}) == nil) {
                        let walletName = "Account \(listWallet.count + 1)"
                        param["walletAddress"] = "\(address)"
                        listWallet.insert(WalletModel(walletName: walletName, walletAddress: "\(address)", walletIndex: 0, seedPhrase: "", privateKey: content, isImportWallet: true), at: 0)
                        for (index, walletModel) in listWallet.enumerated() {
                            walletModel.walletIndex = index
                        }
                        SharedPreference.shared.saveListWallet(listWallet: listWallet)
                        param["walletName"] = walletName
                        param["code"] = CODE_SUCCESS
                        chatChanel?.invokeMethod("importWalletCallback", arguments: param)
                        return param
                    } else {
                        param["walletAddress"] = ""
                        param["walletName"] = ""
                        param["code"] = CODE_ERROR_DUPLICATE
                        chatChanel?.invokeMethod("importWalletCallback", arguments: param)
                        return param
                    }
                } else {
                    param["walletAddress"] = ""
                    param["walletName"] = ""
                    param["code"] = CODE_ERROR
                    chatChanel?.invokeMethod("importWalletCallback", arguments: param)
                    return param
                }
            } else {
                param["walletAddress"] = ""
                param["walletName"] = ""
                param["code"] = CODE_ERROR_WALLET
                chatChanel?.invokeMethod("importWalletCallback", arguments: param)
                return param
            }
        default:
            return param
        }
    }
    
    private func importNft(jsonNft: String, walletAddress: String) -> [String: Any] {
        var code = CODE_SUCCESS
        var listCollectionSupport = [NftModel]()
        
        let jsonData = jsonNft.data(using: .utf8)
        let objectNft = try! JSONDecoder().decode(NftDTO.self, from: jsonData!)
        
        let listAllCollection = SharedPreference.shared.getListNft()
        let checkAddress = listAllCollection.first(where: {$0.walletAddress == walletAddress})
        if checkAddress == nil {
            let listItem = objectNft.listNft?.map{ItemNftModel(id: $0.id ?? "", contract: $0.contract ?? "", uri: $0.uri ?? "")}
            let nftModel = NftModel(walletAddress: walletAddress, collectionAddress: objectNft.contract ?? "", nftName: objectNft.name ?? "", symbol: objectNft.symbol ?? "", item: listItem ?? [])
            print("Fucker \(nftModel.item.count)")
            listCollectionSupport.append(nftModel)
            listCollectionSupport.append(contentsOf: listAllCollection.filter{$0.walletAddress != walletAddress})
        } else {
            let contractNft = objectNft.contract ?? ""
            if checkAddress!.collectionAddress == contractNft {
                var listNft = [ItemNftModel]()
                
                let listNftItem = objectNft.listNft ?? []
                listNftItem.forEach { (nftItemJson) in
                    let id = nftItemJson.id ?? ""
                    if (checkAddress!.item.first(where: {$0.id != id}) == nil) {
                        listNft.append(ItemNftModel(id: id, contract: nftItemJson.contract ?? "", uri: nftItemJson.uri ?? ""))
                    }
                }
                code = listNft.isEmpty ? CODE_ERROR_DUPLICATE : CODE_SUCCESS
                var listNftLocal = [ItemNftModel]()
                checkAddress!.item.forEach { item in
                    if listNft.first(where: {$0.id == item.id}) == nil {
                        listNftLocal.append(item)
                    }
                }
                let nftModel = NftModel(walletAddress: walletAddress, collectionAddress: contractNft, nftName: objectNft.name ?? "", symbol: objectNft.symbol ?? "", item: [])
                nftModel.item.append(contentsOf: listNft)
                nftModel.item.append(contentsOf: listNftLocal)
                listCollectionSupport.append(nftModel)
                listCollectionSupport.append(contentsOf: listCollectionSupport.filter{$0.walletAddress != walletAddress})
            } else {
                let listItem = objectNft.listNft?.map{ItemNftModel(id: $0.id ?? "", contract: $0.contract ?? "", uri: $0.uri ?? "")}
                let nftModel = NftModel(walletAddress: walletAddress, collectionAddress: contractNft, nftName: objectNft.name ?? "", symbol: objectNft.symbol ?? "", item: listItem ?? [])
                listCollectionSupport.append(nftModel)
                listCollectionSupport.append(contentsOf: listAllCollection.filter{$0.collectionAddress != contractNft})
            }
        }
        let param: [String: Any] = ["code": code]
        SharedPreference.shared.saveListNft(listNft: listCollectionSupport)
        chatChanel?.invokeMethod("importNftCallback", arguments: param)
        return param
    }
    
    private func deleteNft(walletAddress: String, collectionAddress: String, nftId: String) -> [String: Any] {
        var listCollection = [NftModel]()
        var isDeleteSuccess = false
        SharedPreference.shared.getListNft().forEach { it in
            if it.walletAddress == walletAddress && it.collectionAddress == collectionAddress {
                var listNft = [ItemNftModel]()
                it.item.forEach { nft in
                    if nft.id == nftId {
                        isDeleteSuccess = true
                    } else {
                        listNft.append(nft)
                    }
                }
                if !listNft.isEmpty {
                    let data = NftModel(walletAddress: walletAddress, collectionAddress: collectionAddress, nftName: it.nftName, symbol: it.symbol, item: listNft)
                    listCollection.append(data)
                }
            }
        }
        SharedPreference.shared.saveListNft(listNft: listCollection)
        let param: [String: Any] = ["isSuccess": isDeleteSuccess]
        chatChanel?.invokeMethod("setDeleteNftCallback", arguments: param)
        return param
    }
    
    private func deleteCollection(walletAddress: String, collectionAddress: String) -> [String: Any] {
        var listNft = [NftModel]()
        var isDeleteSuccess = false
        SharedPreference.shared.getListNft().forEach { collection in
            if collection.walletAddress != walletAddress && collection.collectionAddress != collectionAddress {
                listNft.append(collection)
            } else {
                isDeleteSuccess = true
            }
        }
        SharedPreference.shared.saveListNft(listNft: listNft)
        let param: [String: Any] = ["isSuccess": isDeleteSuccess]
        chatChanel?.invokeMethod("setDeleteCollectionCallback", arguments: param)
        return param
    }
    
    private func signTransactionToken(walletAddress: String,
                                      tokenAddress: String,
                                      toAddress: String,
                                      nonce: String,
                                      chainId: String,
                                      gasPrice: String,
                                      gasLimit: String,
                                      amount: String) -> [String: Any] {
        var param = [String: Any]()
        let walletModel = SharedPreference.shared.getListWallet().first(where: {$0.walletAddress == walletAddress})
        if let walletModel = walletModel, !walletModel.privateKey.isEmpty {
            let privateKey = PrivateKey(data: walletModel.privateKey.hexadecimal!)!
            switch tokenAddress {
            case TOKEN_BNB_ADDRESS:
                let signerInput = EthereumSigningInput.with {
                    $0.nonce = BigInt(nonce)!.serialize()
                    $0.chainID = BigInt(chainId)!.serialize()
                    $0.gasPrice = BigInt(gasPrice.handleAmount(decimal: 9))!.serialize()
                    $0.gasLimit = BigInt(gasLimit)!.serialize()
                    $0.toAddress = toAddress
                    $0.privateKey = privateKey.data
                    $0.transaction = EthereumTransaction.with {
                        $0.transfer = EthereumTransaction.Transfer.with {
                            $0.amount = BigInt(amount.handleAmount(decimal: 18))!.serialize()
                        }
                    }
                }
                let outputBnb: EthereumSigningOutput = AnySigner.sign(input: signerInput, coin: .smartChain)
                let value = outputBnb.encoded.hexString
                param["isSuccess"] = true
                param["signedTransaction"] = value
                break
            default:
                let signerInput = EthereumSigningInput.with {
                    $0.nonce = BigInt(nonce)!.serialize()
                    $0.chainID = BigInt(chainId)!.serialize()
                    $0.gasPrice = BigInt(gasPrice.handleAmount(decimal: 9))!.serialize()
                    $0.gasLimit = BigInt(gasLimit)!.serialize()
                    $0.toAddress = tokenAddress
                    $0.privateKey = privateKey.data
                    $0.transaction = EthereumTransaction.with {
                        $0.erc20Transfer = EthereumTransaction.ERC20Transfer.with {
                            $0.to = toAddress
                            $0.amount = BigInt(amount.handleAmount(decimal: 18))!.serialize()
                        }
                    }
                }
                let outputBnb: EthereumSigningOutput = AnySigner.sign(input: signerInput, coin: .smartChain)
                let value = outputBnb.encoded.hexString
                param["isSuccess"] = true
                param["signedTransaction"] = value
                break
            }
        } else {
            param["isSuccess"] = false
            param["signedTransaction"] = ""
        }
        chatChanel?.invokeMethod("signTransactionTokenCallback", arguments: param)
        return param
    }
    
    private func signTransactionNft(walletAddress: String,
                                    tokenAddress: String,
                                    toAddress: String,
                                    nonce: String,
                                    chainId: String,
                                    gasPrice: String,
                                    gasLimit: String,
                                    tokenId: String) -> [String: Any] {
        var param = [String: Any]()
        let walletModel = SharedPreference.shared.getListWallet().first(where: {$0.walletAddress == walletAddress})
        if let walletModel = walletModel, !walletModel.privateKey.isEmpty {
            let privateKey = PrivateKey(data: walletModel.privateKey.hexadecimal!)!
            let signerInput = EthereumSigningInput.with {
                $0.nonce = BigInt(nonce)!.serialize()
                $0.chainID = BigInt(chainId)!.serialize()
                $0.gasPrice = BigInt(gasPrice)!.serialize()
                $0.gasLimit = BigInt(gasLimit.handleAmount(decimal: 9))!.serialize()
                $0.toAddress = tokenAddress
                $0.privateKey = privateKey.data
                $0.transaction = EthereumTransaction.with {
                    $0.erc721Transfer = EthereumTransaction.ERC721Transfer.with {
                        $0.from = walletAddress
                        $0.to = toAddress
                        $0.tokenID = BigInt(tokenId)!.serialize()
                    }
                }
            }
            let outputBnb: EthereumSigningOutput = AnySigner.sign(input: signerInput, coin: .smartChain)
            let value = outputBnb.encoded.hexString
            param["isSuccess"] = true
            param["signedTransaction"] = value
            param["walletAddress"] = walletAddress
            param["collectionAddress"] = tokenAddress
            param["nftId"] = tokenId
        } else {
            param["isSuccess"] = false
            param["signedTransaction"] = ""
            param["walletAddress"] = ""
            param["collectionAddress"] = ""
            param["nftId"] = ""
        }
        chatChanel?.invokeMethod("signTransactionNftCallback", arguments: param)
        return param
    }
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

extension String {
    
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }

    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
         return String(self[start...])
    }
    
    var hexadecimal: Data? {
        var data = Data(capacity: count / 2)
        
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSRange(startIndex..., in: self)) { match, _, _ in
            let byteString = (self as NSString).substring(with: match!.range)
            let num = UInt8(byteString, radix: 16)!
            data.append(num)
        }
        
        guard data.count > 0 else { return nil }
        
        return data
    }
    
    func handleAmount(decimal: Int) -> String {
        let parts = self.split(separator: ".")
        if self.isEmpty {
            return "0"
        } else {
            if parts.count == 1 {
                var buffer = ""
                var size = 0
                while (size < decimal) {
                    buffer = buffer + "0"
                    size+=1
                }
                return self + buffer
            } else if (parts.count > 1) {
                if parts[1].count >= decimal {
                    let part = String(parts[1])
                    return parts[0] + String(part[0..<decimal])
                } else {
                    let valueAmount = parts[0]
                    let valueDecimal = parts[1]
                    var buffer = ""
                    var size = valueDecimal.count
                    while (size < decimal) {
                        buffer = buffer + "0"
                        size+=1
                    }
                    return valueAmount + valueDecimal + buffer
                }
            } else {
                return "0"
            }
        }
    }
}
