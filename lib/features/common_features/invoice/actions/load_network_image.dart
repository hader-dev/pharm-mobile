import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:pdf/widgets.dart' as pw;

Future<pw.ImageProvider> loadNetworkLogo(String url,
    {double width = 80, double height = 40}) async {
  try {
    final networkService = getItInstance.get<INetworkService>();

    final realUrl = "/files$url";
    final Response<dynamic> response = (await networkService.get(realUrl,
        isBinary: true)) as Response<dynamic>;

    if (response.statusCode == 200 && response.data != null) {
      final Uint8List bytes = Uint8List.fromList(response.data!);
      return pw.MemoryImage(bytes);
    }
    return pw.MemoryImage(Uint8List.fromList([]));
  } catch (e) {
    return pw.MemoryImage(Uint8List.fromList([]));
  }
}
