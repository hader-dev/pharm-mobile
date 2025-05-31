import 'dart:convert';

import 'package:flutter/services.dart';

class DataLoaderHelper {
  static Future<dynamic> loadDummyData(String dataPath) async {
    dynamic data = await rootBundle.loadString(dataPath);
    return data;
  }

  static Future<List> loadJsonData(String dataPath) async {
    String data = await rootBundle.loadString(dataPath);
    var decoded = jsonDecode(data);
    return decoded;
  }
}
