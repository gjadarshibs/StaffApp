import 'dart:convert';
import 'package:flutter/services.dart';
/// This Class is used to fetch json file from asset bundle.
/// It is expected that json file path is added in the pubspec.yaml file in tha assets section
/// otherwise this class fail to work.
class JsonClient {
   JsonClient();
  Future<Map> fecth(String assetPath) async {
    await Future.delayed(Duration(seconds: 2));

    final ByteData data = await rootBundle.load(assetPath);
    final jsonContent = utf8.decode(data.buffer.asUint8List());
    return json.decode(jsonContent);
    // Future<Map> map =
    //     rootBundle.loadStructuredData(assetPath, (jsonString) async {

    //   return json.decode(jsonString);
    // });
    // return map;
  }
}
