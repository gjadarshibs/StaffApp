import 'package:flutter/material.dart';
import '../custom_localization.dart';

/// Contains some useful methods for build contexts.
extension CustomLocalizationExtension on BuildContext {
  /// Returns the string associated to the specified key using EzLocalization.
  String getString(String key, [dynamic args]) => CustomLocalization.of(this).get(key, args);

  /// Allows to change the preferred locale.
  void changeLocale(Locale locale) =>  CustomLocalizationBuilder.of(this).changeLocale(locale);
}