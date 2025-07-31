import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

void main() async {
  Future<String> loadJsonFileString(String path) async {
    return File(path).readAsString();
  }

  final rootDirectory = "C:/Projects/hader-pharm-mobile";
  final jsonString =
      await loadJsonFileString("$rootDirectory/assets/json/town_en.json");

  final List<dynamic> rawList = json.decode(jsonString)['data'];
  final List<Map<String, dynamic>> towns =
      rawList.cast<Map>().map((e) => Map<String, dynamic>.from(e)).toList();

  final Map<int, List<Map<String, dynamic>>> grouped = {};

  for (var town in towns) {
    int wilayaId = town['wilayaId'];
    grouped.putIfAbsent(wilayaId, () => []).add(town);
  }

  final outputDir = Directory('$rootDirectory/assets/json/town/');
  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }

  for (var entry in grouped.entries) {
    final wilayaId = entry.key;
    final fileName = 'town_${wilayaId}_en.json';
    final file = File('${outputDir.path}/$fileName');

    final outputJson = {
      "data": entry.value,
    };

    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert(outputJson),
    );

    debugPrint('✅ Created: ${file.path}');
  }
}
