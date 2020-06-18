import 'package:flutter/material.dart';
import 'package:keychainkeystoreplugin/keychain_keystore_storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final key = "hhh%tttd886";

  @override
  void initState() {
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              FlatButton(onPressed: () => saveData(key), child: Text('Save')),
              FlatButton(onPressed: () => readData(key), child: Text('Read')),
              FlatButton(onPressed: () => delData(key), child: Text('Delete'))
            ],
          ),
        ),
      ),
    );
  }
}
