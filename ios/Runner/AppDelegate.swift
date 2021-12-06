import UIKit
import Flutter

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
        if call.method == "checkPassword" {
            if let arguments = call.arguments as? [String: Any], let password = arguments["password"] as? String {
                result(checkPassword(password: password))
            }
        }
    }
    
    private func checkPassword(password: String) -> [String: Any] {
        var params: [String: Any] = [:]
        params["isCorrect"] = !password.isEmpty
        return params
    }
}
