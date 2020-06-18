import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

/// Callback allowing to get the language path according to the specified locale.
typedef GetPathFunction = String Function(Locale locale);

/// The CustomLocalization class.
class CustomLocalization {
  /// The current locale.
  final Locale locale;

  /// The get path function.
  final GetPathFunction getPathFunction;

  /// The string to return if the key is not found.
  final String notFoundString;

  /// The localized strings.
  final Map<String, String> _strings = HashMap();

  /// Creates a new custom localization instance.
  CustomLocalization({
    this.locale,
    this.getPathFunction,
    this.notFoundString,
  });

  /// Returns the CustomLocalization instance attached to the specified build config.
  static CustomLocalization of(BuildContext context) =>
      Localizations.of<CustomLocalization>(context, CustomLocalization);

  /// Loads the localized strings.
  Future<bool> load() async {
    try {
      final data = await rootBundle.loadString(getPathFunction(locale));
      Map<String, dynamic> strings = json.decode(data);
      strings.forEach((String key, dynamic data) => _addValues(key, data));
      return true;
    } catch (exception, stacktrace) {
      print(exception);
      print(stacktrace);
    }
    return false;
  }

  /// Only for testing purpose.
  Future<bool> loadTestData(Map<String, dynamic> testData) async {
    testData.forEach((String key, dynamic data) => _addValues(key, data));
    return true;
  }

  /// Returns the string associated to the specified key.
  String get(String key, [dynamic args]) {
    var value = _strings[key];
    if (value == null) {
      return notFoundString ?? key;
    }

    if (args != null) {
      value = _formatReturnValue(value, args);
    }

    return value;
  }

  /// The default get path function.
  static String defaultGetPathFunction(Locale locale) =>
      'assets/languages/${locale.languageCode}.json';

  // static String defaultGetPathFunction(Locale locale) => 'assets/locale/localization_${locale.languageCode}.json';

  /// Adds the values to the current map.
  void _addValues(String key, dynamic data) {
    if (data is Map) {
      data.forEach(
          (subKey, subData) => _addValues(key + '.' + subKey, subData));
      return;
    }

    if (data != null) {
      _strings[key] = data.toString();
    }
  }

  /// Formats the return value according to the specified arguments.
  String _formatReturnValue(String value, dynamic arguments) {
    if (arguments is List) {
      for (var i = 0; i < arguments.length; i++) {
        value =
            value.replaceAll('{' + i.toString() + '}', arguments[i].toString());
      }
    } else if (arguments is Map) {
      arguments.forEach((formatKey, formatValue) => value = value.replaceAll(
          '{' + formatKey.toString() + '}', formatValue.toString()));
    }
    return value;
  }
}
