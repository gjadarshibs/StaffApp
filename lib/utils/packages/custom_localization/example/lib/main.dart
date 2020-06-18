import 'dart:async';
import 'package:flutter/material.dart';
import 'package:example/signupscreen.dart';
import 'package:custom_localization/custom_localization.dart';


Future<Null> main() async {
  runApp(new LocalisedApp());
}

class LocalisedApp extends StatefulWidget {
  @override
  LocalisedAppState createState() {
    return new LocalisedAppState();
  }
}

class LocalisedAppState extends State<LocalisedApp> {

  @override
  void initState() {
    super.initState();
  }

  String filePathFunction(Locale locale) => 'assets/languages/localization_${locale.languageCode}.json';

  @override
  Widget build(BuildContext context) => CustomLocalizationBuilder(
    delegate: CustomLocalizationDelegate(
        supportedLocales: [
          Locale('en'),
          Locale('hi'),
        ],
        getPathFunction: filePathFunction
    ),
    builder: (context, localizationDelegate) => MaterialApp(
      title: 'CustomLocalization Demo',
      home: SignUpUI(),
      localizationsDelegates: localizationDelegate.localizationDelegates,
      supportedLocales: localizationDelegate.supportedLocales,
      localeResolutionCallback: localizationDelegate.localeResolutionCallback,
    ),
  );

}
