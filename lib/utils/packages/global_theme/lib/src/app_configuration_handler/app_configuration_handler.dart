import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'model/app_configuration.dart';

/// Parse the json file from the given asset folder path
///
/// [assetsPath] is tha absolute path of json file

Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
  print('--- Parse json from: $assetsPath');
  final data = await rootBundle.loadString(assetsPath);
  final jsonResult = json.decode(data);
  print(jsonResult);
  return jsonResult;
}

/// Parse configuration file and return as a POJO
///
/// [themeFile] is the json file name

Future<AppConfigurationContainer> getConfigurationFile(String themeFile) async {
  var configJson = await parseJsonFromAssets(themeFile);
  return AppConfigurationContainer.fromJson(configJson);
}
