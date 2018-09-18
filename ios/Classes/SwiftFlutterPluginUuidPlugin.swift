import Flutter
import UIKit
import SAMKeychain

public class SwiftFlutterPluginUuidPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_plugin_uuid", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterPluginUuidPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if(call.method == "getUuid"){
        self.getUniqueDeviceIdentifier(result: result)
    }
  }
    
  private func getUniqueDeviceIdentifier(result: FlutterResult) {
        let bundleName = Bundle.main.infoDictionary!["CFBundleName"] as! String
        let bundleId = Bundle.main.bundleIdentifier!
        
        var applicationUUID = SAMKeychain.password(forService: bundleName, account: bundleId)
        
        if applicationUUID == nil {
            
            applicationUUID = (UIDevice.current.identifierForVendor?.uuidString)!
            let query = SAMKeychainQuery()
            query.service = bundleName
            query.account = bundleId
            query.password = applicationUUID
            query.synchronizationMode = SAMKeychainQuerySynchronizationMode.no
            
            do {
                try query.save()
            } catch let error as NSError {
                print("SAMKeychainQuery Exception: \(error)")
            }
        }
        
        if(applicationUUID==nil||applicationUUID==""){
            result(FlutterError.init(code: "UNAVAILABLE",
                                     message: "UDID not available",
                                     details: nil));
        }else{
            result(applicationUUID)
        }
    }
}
