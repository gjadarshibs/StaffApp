
import 'dart:convert';
import 'package:flutter/services.dart';
import 'app_enviroment.dart';


class FlavorConfig {
  final _filePath = 'flavour/config.json';
  final AppEnvironment environment;

  Map<String, dynamic> get properties {
    return _properties ?? {};
  }
  Map<String, dynamic> _properties;

  static FlavorConfig _instance;

  FlavorConfig._internal(this.environment);

  static FlavorConfig get instance {

    return _instance;
  }

  factory FlavorConfig({ AppEnvironment environment}) {

    _instance ??= FlavorConfig._internal(environment);
    return _instance;
  }

  void initialize() async {
    final configString = await rootBundle.loadString(_filePath);
    final configData = json.decode(configString) as Map<String, dynamic>;
    _properties = configData[environment.value];
  }
}

extension AppEnvironmentExtension on AppEnvironment {

  String get value {
    switch(this) {
      case AppEnvironment.dev:
        return 'DEV';
      case AppEnvironment.test:
        return 'TEST';
      case AppEnvironment.prod:
        return 'PROD';
      default:
        return 'DEV';
    }
  }

}