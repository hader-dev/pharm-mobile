import 'package:flutter/cupertino.dart';

class ColorHexConverter {
  static Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }

  static Future<List> convertStatisticsColors(List statisticsData) async {
    await Future.forEach(statisticsData, (element) async {
      element['color'] = ColorHexConverter.hexToColor('#${element['color']}');
    });
    return statisticsData;
  }
}
