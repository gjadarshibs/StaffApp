import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });
  group('Shared Pref Extension', () {
    test('Store and retrieve text from shared pref', () async {
      final value = 'Plain Text';
      final key = 'KeyTT';
      SharedPreferences.setMockInitialValues({key: value});

      final storedValue = await key.getStringPreferenceValue();
      expect(value, storedValue);
    });
    test('Retrieved number from shared pref', () async {
      final value = 300;
      final key = 'KeyTT';
      SharedPreferences.setMockInitialValues({key: value});
      final storedValue = await key.getIntegerPreferenceValue();
      expect(value, storedValue);
    });
    test('Retrieved bool from shared pref', () async {
      final value = true;
      final key = 'KeyTT';
      SharedPreferences.setMockInitialValues({key: value});
      final storedValue = await key.getBoolPreferenceValue();
      expect(value, storedValue);
    });
    test('Retrieved list of strings from shared pref', () async {
      final value = ['A', 'B', 'C'];
      final key = 'KeyTT';
      SharedPreferences.setMockInitialValues({key: value});
      final storedValue = await key.getStringListPreferenceValue();
      expect(value, storedValue);
    });
  });
}
