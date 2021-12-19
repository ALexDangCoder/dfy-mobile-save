import UIKit
import Flutter
import WalletCore

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var chatChanel: FlutterMethodChannel?
    
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
//        if call.method == "checkPassword" {
//            if let arguments = call.arguments as? [String: Any], let password = arguments["password"] as? String {
//                result(checkPassword(password: password))
//            }
//        }
        if call.method == "getConfig" {
            result(getConfigWallet())
        }
//        if call.method == "earseWallet" {
//            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String {
//                result(eraseWallet(walletAddress: walletAddress))
//            }
//        }
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
        params["isCorrect"] = !password.isEmpty
        chatChanel?.invokeMethod("checkPasswordCallback", arguments: params)
        return params
    }
    
    private func generateWallet() -> [String: Any] {
        let wallet = HDWallet(strength: 128, passphrase: "")
        let seedPhrase = wallet!.mnemonic
        let address = wallet?.getAddressForCoin(coin: .smartChain)
        let walletName = "Account 1"
        let privateKey = (wallet?.getKeyForCoin(coin: .smartChain).data)!.hexEncodedString()
        var params: [String: Any] = [:]
        params["walletName"] = walletName
        params["walletAddress"] = address
        params["privateKey"] = privateKey
        params["passPhrase"] = seedPhrase
        chatChanel?.invokeMethod("generateWalletCallback", arguments: params)
        return params
    }
    
    private func getListWallet(password: String) -> [[String: Any]] {
        var params: [[String: Any]] = []
        let param1: [String: Any] = [
            "walletName": "walletName1",
            "walletAddress": "0x753EE7D5FdBD248fED37add0C951211E03a7DA15",
        ]
        params.append(param1)
        let param2: [String: Any] = [
                    "walletName": "walletName2",
                    "walletAddress": "0x753EE7D5FdBD248fED37add0C951211E03a7DA15",
                ]
        params.append(param2)
        chatChanel?.invokeMethod("getListWalletsCallback", arguments: params)
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
    
    private func getTokens(walletAddress: String) -> [[String: Any]] {
        var params: [[String: Any]] = []
        let array: [UInt8] = Array("0x753EE7D5FdBD248fED37add0C951211E03a7DA15".utf8)
        let param1: [String: Any] = [
            "tokenFullName": "BitCoin",
            "tokenShortName": "BTC",
            "tokenAddress": "0x753EE7D5FdBD248fED37add0C951211E03a7DA15",
            "iconToken": array,
        ]
        params.append(param1)
        let param2: [String: Any] = [
            "tokenFullName": "Binance",
            "tokenShortName": "BNB",
            "tokenAddress": "0x753EE7D5FdBD248fED37add0C951211E03a7DA15",
            "iconToken": array,
        ]
        params.append(param2)
        chatChanel?.invokeMethod("getTokensCallback", arguments: params)
        return params
    }
    
    private func storeWallet(seedPhrase: String, walletName: String, privateKey: String, walletAddress: String) -> [String: Any] {
        var params: [String: Any] = [:]
        params["isSuccess"] = true
        chatChanel?.invokeMethod("storeWalletCallback", arguments: params)
        return params
    }
    
    private func setConfig(appLock: Bool, faceID: Bool) -> [String: Any] {
        var params: [String: Any] = [:]
        params["isSuccess"] = true
        chatChanel?.invokeMethod("setConfigCallback", arguments: params)
        return params
    }
    
    private func savePassword(password: String) -> [String: Any] {
        if (!password.isEmpty) {
            var params: [String: Any] = [:]
            params["isSuccess"] = true
            chatChanel?.invokeMethod("savePasswordCallback", arguments: params)
            return params
        }
        return [:]
    }
    
    private func getListWallets() -> [[String: Any]] {
        var listParam: [[String: Any]] = []
        return listParam
    }

    private func getConfigWallet() -> [String: Any] {
        var params: [String: Any] = [:]
        params["isAppLock"] = true
        params["isFaceID"] = true
        params["isWalletExist"] = true
        chatChanel?.invokeMethod("getConfigCallback", arguments: params)
        return params 
    }

    private func eraseWallet(walletAddress: String) -> [String: Any] {
        var params: [String: Any] = [:]
        params["isSuccess"] = true
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
