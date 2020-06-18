import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Shared preference storage is added as an extension of string.
/// Calling respective methods with a key will return the stored value in the shared preference.
extension StringPreference on String {
  /// Return the string vale stored in shared preference with respect to the key.
  /// [this] refers the key for the value.
  Future<String> getStringPreferenceValue() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(this) ? prefs.getString(this) ?? '' : '';
  }

  /// Return the integer value stored in shared preference with respect to the key.
  /// [this] refers the key for the value.
  Future<int> getIntegerPreferenceValue() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(this) ? prefs.getInt(this) ?? 0 : 0;
  }

  /// Return the double value stored in shared preference with respect to the key.
  /// [this] refers the key for the value.
  Future<double> getDoublePreferenceValue() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(this) ? prefs.getDouble(this) ?? 0.0 : 0.0;
  }

  /// Return the [bool] value stored in shared preference with respect to the key.
  /// [this] refers the key for the value.
  Future<bool> getBoolPreferenceValue() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(this) ? prefs.getBool(this) ?? false : false;
  }

  /// Return a list of string stored in shared preference with respect to the key.
  /// [this] refers the key for the value.
  Future<List<String>> getStringListPreferenceValue() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(this) ? prefs.getStringList(this) ?? [] : [];
  }

  /// Store a string value to the shared preference.
  /// return a [bool] if the transaction is success.
  /// [key] is the key for the value.
  /// [this] is the value to be stored.
  Future<bool> putStringPreferenceValue({@required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, this).then((bool success) => success);
  }

  /// Delete the data mapped with the given key from shared preference.
  /// [this] refers the key for the data.
  Future<bool> deletePreferenceValue() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(this);
  }
}

/// Shared preference storage is added as an extension of bool.
extension BoolPreference on bool {
  /// Store a [bool] value to the shared preference.
  /// [key] is the key for the value.
  /// [this] is the value to be stored.
  Future<bool> putBoolPreferenceValue({@required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, this).then((bool success) => success);
  }
}

/// Shared preference storage is added as an extension of num.
extension IntegerPreference on num {
  /// Store a double or int value to the shared preference.
  /// return a [bool] if the transaction is success.
  /// [key] is the key for the value.
  /// [this] is the value to be stored.
  Future<bool> putNumberPreferenceValue({@required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    switch (runtimeType) {
      case double:
        return prefs.setDouble(key, this).then((bool success) => success);
        break;
      case int:
      default:
        return prefs.setInt(key, this).then((bool success) => success);
    }
  }
}

/// Shared preference storage is added as an extension of list of strings.
extension ListPreference on List<String> {
  /// Store a [List<String>] value to the shared preference.
  /// return a [bool] if the transaction is success.
  /// [key] is the key for the value.
  /// [this] is the value to be stored.
  Future<bool> putStringListPreferenceValue({@required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(key, this).then((bool success) => success);
  }
}
