import 'package:http/http.dart' as http;

abstract class INetworkService {
  String baseUrl = "https://api.example.com";
  Future<http.Response> get(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParams,
  });
  Future<http.Response> post(String url,
      {Map<String, String>? headers, Map<String, String>? queryParams, dynamic payload});
  Future<http.Response> patch(String url,
      {Map<String, String>? headers, Map<String, String>? queryParams, dynamic payload});
  Future<http.Response> put(String url,
      {Map<String, String>? headers, Map<String, String>? queryParams, dynamic payload});
  Future<http.Response> delete(String url,
      {Map<String, String>? headers, Map<String, String>? queryParams, dynamic payload});

  String getImagePath(String imageName);
}
