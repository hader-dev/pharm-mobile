abstract class INetworkService {
  String baseUrl = "https://api.example.com";

  dynamic getClientInstance();

  Future<dynamic> sendRequest(Function sendFunc) async {}
  Future<dynamic> get(
    String url, {
    Map<String, String>? headers,
    Map<String, Object>? queryParams,
  });
  Future<dynamic> post(String url,
      {Map<String, String>? headers,
      Map<String, Object>? queryParams,
      dynamic payload});
  Future<dynamic> patch(String url,
      {Map<String, String>? headers,
      Map<String, Object>? queryParams,
      dynamic payload});
  Future<dynamic> put(String url,
      {Map<String, String>? headers,
      Map<String, Object>? queryParams,
      dynamic payload});
  Future<dynamic> delete(String url,
      {Map<String, String>? headers,
      Map<String, Object>? queryParams,
      dynamic payload});
  String getFilesPath(String imageName);
  Future<void> deletePersistantCookiesJar();
  void refreshAuthHeader(String? token);
}
