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
        if call.method == "getListWallets" {
            if let arguments = call.arguments as? [String: Any], let password = arguments["password"] as? String {
                result(getListWallet(password: password))
            }
        }
        if call.method == "getNFT" {
            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String {
                result(getNFT(walletAddress: walletAddress))
            }
        }
        if call.method == "getTokens" {
            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String {
                result(getTokens(walletAddress: walletAddress))
            }
        }
        if call.method == "generateWallet" {
            if let arguments = call.arguments as? [String: Any], let password = arguments["password"] as? String {
                result(generateWallet(password: password))
            }
        }
        if call.method == "storeWallet" {
            if let arguments = call.arguments as? [String: Any], let seedPhrase = arguments["seedPhrase"] as? String, let walletName = arguments["walletName"] as? String, let password = arguments["password"] as? String {
                result(storeWallet(seedPhrase: seedPhrase, walletName: walletName, password: password))
            }
        }
        if call.method == "setConfig" {
            if let arguments = call.arguments as? [String: Any], let isAppLock = arguments["isAppLock"] as? Bool, let isFaceID = arguments["isFaceID"] as? Bool, let password = arguments["password"] as? String {
                result(setConfig(appLock: isAppLock,faceID: isFaceID,password: password))
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
        if call.method == "earseWallet" {
            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String {
                result(eraseWallet(walletAddress: walletAddress))
            }
        }
        if call.method == "earseAllWallet" {
            if let arguments = call.arguments as? [String: Any], let type = arguments["type"] as? String {
                result(eraseAllWallet(type: type))
            }
        }



        guard call.method == "signTransaction" else {
            result(FlutterMethodNotImplemented)
            return
        }
    }
}

extension AppDelegate {
    private func checkPassword(password: String) -> [String: Any] {
        var params: [String: Any] = [:]
        params["isCorrect"] = !password.isEmpty
        chatChanel?.invokeMethod("checkPasswordCallback", arguments: params)
        return params
    }
    
    private func generateWallet(password: String) -> [String: String] {
        var params: [String: String] = [:]
        params["walletAddress"] = "0x753EE7D5FdBD248fED37add0C951211E03a7DA15"
        params["privateKey"] = "e507e499158b5b6e1a89ad1e65250f6c38a28d455c37cf23c41f4bdd82436e5a"
        params["passPhrase"] = "party response give dove tooth master flip video permit game expire token"
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
    
    private func storeWallet(seedPhrase: String, walletName: String, password: String) -> [String: Any] {
        var params: [String: Any] = [:]
        params["isSuccess"] = true
        chatChanel?.invokeMethod("storeWalletCallback", arguments: params)
        return params
    }
    
    private func setConfig(appLock: Bool, faceID: Bool, password: String) -> [String: Any] {
        var params: [String: Any] = [:]
        params["isSuccess"] = true
        chatChanel?.invokeMethod("setConfigCallback", arguments: params)
        return params
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
