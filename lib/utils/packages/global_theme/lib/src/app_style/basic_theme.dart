import 'package:flutter/material.dart';
import 'package:global_theme/src/app_configuration_handler/model/app_configuration.dart';

/// Here we pass the configuration json object model, from which the theme styles are configured and return a ThemeData.
/// The default theme mode is set as light mode.
/// (brightness: Brightness.light) will enable the dark mode, ensure that to define the dark mode theme colors
///
/// [configObject] is a the theme configuration json model object contains theme params

ThemeData generateThemeData(AppConfigurationContainer configObject) {
  /// Font family is set for ThemeData
  final base = ThemeData(fontFamily: configObject.appTextStyles.fontFamily);

  /// Here the basic text styles are configured based on the params define in configuration file
  /// [base] is reference to the TextTheme property of ThemeData

  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
      headline1: base.headline1.copyWith(
        fontSize: configObject.appTextStyles.heading.fontSize,
        color: HexColor.fromHex(configObject.appTextStyles.heading.color),
      ),
      subtitle1: base.subtitle1.copyWith(
          fontSize: configObject.appTextStyles.subHeading.fontSize,
          color: HexColor.fromHex(configObject.appTextStyles.subHeading.color)),
      bodyText1: base.bodyText1.copyWith(
          fontSize: configObject.appTextStyles.body.fontSize,
          color: HexColor.fromHex(configObject.appTextStyles.body.color)),
    );
  }

  /// Here the app bar styles are configured based on the params define in configuration file
  /// [base] is reference to the TextTheme property of ThemeData

  AppBarTheme _basicAppBarTheme(AppBarTheme base) {
    return base.copyWith(
        color: HexColor.fromHex(configObject.appColor.appBarColor));
  }

  return base.copyWith(
    brightness: Brightness.light,
    textTheme: _basicTextTheme(base.textTheme),
    appBarTheme: _basicAppBarTheme(base.appBarTheme),
    primaryColor: HexColor.fromHex(configObject.appColor.primaryColor),
    accentColor: HexColor.fromHex(configObject.appColor.accentColor),
    scaffoldBackgroundColor:
        HexColor.fromHex(configObject.appColor.scaffoldBackgroundColor),
  );
}

/// Extension converts HEX color string to Color object
extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
