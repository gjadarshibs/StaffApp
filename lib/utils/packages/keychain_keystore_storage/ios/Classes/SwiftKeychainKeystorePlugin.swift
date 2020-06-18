import Flutter
import UIKit


public class SwiftKeychainKeystorePlugin: NSObject, FlutterPlugin {
    private let KEYCHAIN_SERVICE = "flutter_secret_storage_service"
    private let CHANNEL_NAME = "keychainkeystoreplugin"
    private let InvalidParameters = "Invalid parameter's type"
    private var query: [AnyHashable : Any]?
    
    
    public override init() {
        query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrService: KEYCHAIN_SERVICE]
    }
    
    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "keychainkeystoreplugin", binaryMessenger: registrar.messenger())
        let instance = SwiftKeychainKeystorePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments else {
            result("iOS could not recognize flutter arguments in method: (sendParams)")
            return
        }
        // let myArguments = arguments as? [String: Any]
        
        if ("read" == call.method) {
            guard let myArguments = arguments as? [String: Any] else {  result("Arguments are needed to execute this action.Ï")
                return
            }
            // let options = myArguments["options"] as? [String: Any]
            
            let key = myArguments["key"] as? String
            
            let value = read(key, forGroup: nil)
            
            result(value)
        } else if ("write" == call.method) {
            guard let myArguments = arguments as? [String: Any] else {  result(false)
                return}
            let options = myArguments["options"] as? [String: Any]
            
            let key = myArguments["key"] as? String
            let value = myArguments["value"] as? String
            let accessibility = options?["accessibility"] as? String
            if (value == nil) {
                result(false)
                return
            }
            let status = write(value, forKey: key, forGroup: nil, accessibilityAttr: accessibility)
            
            result(status)
        }
        else if ("delete" == call.method) {
            guard let myArguments = arguments as? [String: Any] else {  result(false)
                return
            }
            //let options = myArguments["options"] as? [String: Any]
            
            let key = myArguments["key"] as? String
            let status = delete(key, forGroup: nil)
            result(status)
        }
        else {
            result(FlutterMethodNotImplemented)
        }
    }
    func write(_ value: String?, forKey key: String?, forGroup groupId: String?, accessibilityAttr accessibility: String?) -> Bool {
        var search = query
        var isSuccess = true;
        if groupId != nil {
            search?[kSecAttrAccessGroup] = groupId ?? ""
        }
        
        search?[kSecAttrAccount] = key ?? ""
        
        search?[kSecMatchLimit] = kSecMatchLimitOne
        
        
        // The default setting is kSecAttrAccessibleWhenUnlocked
        var attrAccessible = kSecAttrAccessibleWhenUnlocked
        if accessibility != nil {
            if (accessibility == "passcode") {
                attrAccessible = kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly
            } else if (accessibility == "unlocked") {
                attrAccessible = kSecAttrAccessibleWhenUnlocked
            } else if (accessibility == "unlocked_this_device") {
                attrAccessible = kSecAttrAccessibleWhenUnlockedThisDeviceOnly
            } else if (accessibility == "first_unlock") {
                attrAccessible = kSecAttrAccessibleAfterFirstUnlock
            } else if (accessibility == "first_unlock_this_device") {
                attrAccessible = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
            }
        }
        
        
        var status: OSStatus = SecItemCopyMatching(search! as CFDictionary, nil)
        
        if status == noErr {
            search?[kSecMatchLimit] = nil
            
            
            let update =  [
                kSecValueData: value!.data(using: .utf8) as Any,
                kSecAttrAccessible: attrAccessible
                ] as [CFString : Any]
            
            
            status = SecItemUpdate(search! as CFDictionary, update as CFDictionary)
            
            if status != noErr {
                print("SecItemUpdate status = \(Int(status))")
            }
            if status != errSecSuccess {
                isSuccess = false
            }
            
            
        } else {
            search?[kSecValueData] = value!.data(using: .utf8)
            
            search?[kSecMatchLimit] = nil
            
            search?[kSecAttrAccessible] = attrAccessible
            
            
            status = SecItemAdd(search! as CFDictionary, nil)
            
            if status != noErr {
                print("SecItemAdd status = \(Int(status))")
            }
            if status != errSecSuccess {
                isSuccess = false
            }
        }
        return isSuccess
        
    }
    
    func read(_ key: String?, forGroup groupId: String?) -> String? {
        var search = query
        if groupId != nil {
            search?[kSecAttrAccessGroup] = groupId ?? ""
            
        }
        search?[kSecAttrAccount] = key ?? ""
        
        search?[kSecReturnData] = kCFBooleanTrue
        
        
        var resultData: CFTypeRef?
        
        var status: OSStatus
        status = SecItemCopyMatching(search! as CFDictionary, &resultData)
        
        var value: String?
        if status == noErr {
            let data = resultData as? Data
            if let data = data {
                value = String(data: data, encoding: .utf8)
            }
        }
        
        return value
    }
    func delete(_ key: String?, forGroup groupId: String?) -> Bool {
        var search = query
        if groupId != nil {
            search?[kSecAttrAccessGroup] = groupId ?? ""
            
        }
        search?[kSecAttrAccount] = key ?? ""
        
        search?[kSecReturnData] = kCFBooleanTrue
        
        
        let status = SecItemDelete(search! as CFDictionary)
        return (status == errSecSuccess || status == errSecItemNotFound ) ? true : false
    }
}
