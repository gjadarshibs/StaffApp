#import "KeychainKeystorePlugin.h"
#if __has_include(<keychainkeystoreplugin/keychainKeystorePlugin-Swift.h>)
#import <keychainkeystoreplugin/keychainKeystorePlugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "keychainKeystorePlugin-Swift.h"
#endif

@implementation KeychainKeystorePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftKeychainKeystorePlugin registerWithRegistrar:registrar];
}
@end
