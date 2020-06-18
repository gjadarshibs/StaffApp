import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keychainkeystoreplugin/keychain_keystore_storage.dart';

void main() {
  const channel = MethodChannel('keychainkeystoreplugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getData', () async {
    expect(await 'key'.readFromKechainOrKeystore(), '42');
  });
}
