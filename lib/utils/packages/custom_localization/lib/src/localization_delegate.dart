import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'localization.dart';

/// The CustomLocalization delegate class.
class CustomLocalizationDelegate extends LocalizationsDelegate<CustomLocalization> {
  /// Creates a new app localization delegate instance.
  const CustomLocalizationDelegate({
    this.supportedLocales = const [Locale('en')],
    this.getPathFunction = CustomLocalization.defaultGetPathFunction,
    this.notFoundString,
    this.locale,
  });

  /// Contains all supported locales.
  final List<Locale> supportedLocales;

  /// The get path function.
  final GetPathFunction getPathFunction;

  /// The string to return if the key is not found.
  final String notFoundString;

  /// The locale to force (if specified, not recommended except under special circumstances).
  final Locale locale;


  @override
  bool isSupported(Locale locale) => _isLocaleSupported(supportedLocales, locale) != null;

  @override
  Future<CustomLocalization> load(Locale locale) async {
    final customLocalization = CustomLocalization(
      locale: this.locale ?? locale,
      getPathFunction: getPathFunction,
      notFoundString: notFoundString,
    );

    await customLocalization.load();
    return customLocalization;
  }

  @override
  bool shouldReload(CustomLocalizationDelegate old) => old.locale != locale;

  /// The default locale resolution callback.
  Locale localeResolutionCallback(
    Locale locale,
    Iterable<Locale> supportedLocales,
  ) {

    final localeToCheck = (this.locale != null) ? this.locale : locale;
     if (localeToCheck == null) return supportedLocales.first;
    return _isLocaleSupported(supportedLocales, localeToCheck) ?? supportedLocales.first;
  }

  /// The localization delegates to add in your application.
  List<LocalizationsDelegate> get localizationDelegates => [
        this,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];

  /// Returns the locale if it's supported by this localization delegate, null otherwise.
  Locale _isLocaleSupported(List<Locale> supportedLocales, Locale locale) {
    for (final supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        print(supportedLocale);
        return supportedLocale;
      }
    }
    return null;
  }
}
