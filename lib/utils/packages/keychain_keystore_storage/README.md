# kechain_keystore
A flutter package that store sensitive data in platform specific secured key storage containers.
We use Keychain for iOS and Keystore for Android.

## How to use this package ?
* Copy and paste this package into your workspace.
* Import the keychain_keystore package into your project.  
````
import 'package:keychainkeystoreplugin/keychain_keystore_storage.dart';
````
* Mention the package in the pubspec.yaml file on your project. Refer the below snapshot 
```
keychainkeystoreplugin:
    path: ‘package location’
```

| Operation   | Reference Code                                         |
| ----------- | ------------------------------------------------------ | 
| Store       | await 'password'.writeIntoKeychainOrKeystore(key: key);|                                        
| Read        | await ‘key'.readFromKeychainOrKeystore();              |              
| Delete      | await ‘key'.deleteFromKeychainOrKeystore();            |                

## Example

```
/// Here we save the credentials or sensitive data into Keystore or Keychain bases of the platform.
  saveData(String key) async {
    await 'password'.writeIntoKechainOrKeystore(key: key).then((status) {
      print(status ? "Saved" : "Failed");
    });
  }

/// Here delete the data from Keystore or Keychain mapped with the given key.
  delData(String key) async {
    await key.deleteFromKeychainKeystore().then((value) {
      print(value ? "Deleted" : "Failed");
    });
  }

/// Read a value against the key from the Keystore or Keychain.
  readData(String key) async {
    await key.readFromKechainOrKeystore().then((value) {
      print(value != null ? "The data is : $value" : "Failed");
    });
  }
```








