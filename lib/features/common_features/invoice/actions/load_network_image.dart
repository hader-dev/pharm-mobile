import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:pdf/widgets.dart' as pw;

Future<pw.ImageProvider> loadNetworkLogo(String url,
    {double width = 80, double height = 40}) async {
  final Response<dynamic> response = (await getItInstance
          .get<INetworkService>()
          .get(url, isBinary:true))
      as Response<dynamic>;

  if (response.statusCode == 200 && response.data != null) {
    final Uint8List bytes = Uint8List.fromList(response.data!);
    return pw.MemoryImage(bytes);
  } else {
    throw Exception("Failed to load logo from $url");
  }
}
