import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:custom_localization/custom_localization.dart';

import 'custom_localization_test_data.dart';

void main() {
  group('localization', () {

    final customLocalizationDelegate =
        CustomLocalizationDelegate(
            supportedLocales: [Locale('en'), Locale('fr')]);

    CustomLocalization customLocalization;
    setUpAll(() async {
      customLocalization = await customLocalizationDelegate.load(Locale('en'));
    });

    test('supportedLocales list check', () {
      expect(customLocalizationDelegate.supportedLocales,
          [Locale('en'), Locale('fr')]);
    });

    test('is customLocalization object created', () {
      expect(customLocalization, isInstanceOf<CustomLocalization>());
    });

    test('Check locale in supported list', () {
      expect(customLocalizationDelegate.isSupported(Locale('en', 'us')), true);
      expect(customLocalizationDelegate.isSupported(Locale('hi', 'in')), false);
    });

  });

  group('Translation check', () {
    final customLocalizationDelegate =
        CustomLocalizationDelegate(
            supportedLocales: [Locale('en'), Locale('fr')]);

    CustomLocalization customLocalization;
    setUpAll(() async {
      customLocalization = await customLocalizationDelegate.load(Locale('en'));
      final testData = await LocalizationTestData.content();
      await customLocalization.loadTestData(testData);
    });

    test('finds and returns resource', () {
      expect(customLocalization.get('welcome'), 'Welcome');
    });

    test('can resolve resource in any nest level', () {
      expect(customLocalization.get('animals.dog'), 'Dog');
    });

    test('can resolve resource in a specific format', () {
      expect(customLocalization.get('format', {'count': '10'}),
          'Number of count is 10');
    });
  });
}
