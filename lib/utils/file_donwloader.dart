import 'dart:async';

import 'package:http/http.dart' as http;

class FilesDownloaderManager {
  static const String appDefaultDir = "/storage/emulated/0/cri";
  static Future<(http.StreamedResponse, int)> downLoadFile({
    required String fileUrl,
    Map<String, String>? headers,
  }) async {
    http.Client httpClientInstance = http.Client();
    http.Request request = http.Request("GET", Uri.parse(fileUrl));
    request.headers.addAll(headers ?? <String, String>{});

    http.StreamedResponse response = await httpClientInstance.send(request);
    if (response.statusCode != 200) throw "download failed";
    int contentLength = response.contentLength ?? 0;
    return (response, contentLength);
  }
}
