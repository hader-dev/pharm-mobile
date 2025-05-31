import 'package:http/http.dart' as http;

import '../../../utils/urls.dart';
import '../auth/token_manager.dart';

import 'dart:convert';

import 'network_interface.dart';

class NetworkManager extends INetworkService {
  late http.Client _client;

  static final NetworkManager _instance = NetworkManager._internal();

  static NetworkManager get instance {
    return _instance;
  }

  static Map<String, String> defaultHeaders = <String, String>{};

  static http.Client get clientInstance => _instance._client;

  NetworkManager._internal();

  // init(
  //     String apiUrl,
  //     http.Client client,
  //     TokenManager tokenManager

  //     ) async {
  //   await EnvHelper.loadAppEnvFile();
  //   TokenManager.instance.init(const FlutterSecureStorage());
  //   final tokenManager = TokenManager.instance;

  //   Urls.domainName = EnvHelper.getStoredEnvValue(EnvHelper.keyUrl);

  //   // baseUrl = apiUrl;

  //   _client = http.Client();

  //   String? currentToken = await tokenManager.getAccessToken();
  //   _initDefaultHeaders(currentToken);
  // }

  init(String apiUrl, http.Client client, TokenManager tokenManager) async {
    baseUrl = apiUrl;
    _client = client;

    String? currentToken = await tokenManager.getAccessToken();

    initDefaultHeaders(currentToken);
  }

  Future<http.Response> sendRequest(Function sendFunc) async {
    return sendFunc();
  }

  @override
  Future<http.Response> patch(String url,
      {Map<String, String>? headers, Map<String, String>? queryParams, dynamic payload}) async {
    http.Response apiResponse = await _client.patch(prepareUrl(url, queryParams ?? <String, String>{}),
        body: payload != null ? jsonEncode(payload) : null,
        headers: _mergeCustomHeaders(headers ?? <String, String>{}));
    return apiResponse;
  }

  @override
  Future<http.Response> delete(String url,
      {Map<String, String>? headers, Map<String, String>? queryParams, payload}) async {
    http.Response apiResponse = await _client.delete(
        body: payload,
        prepareUrl(url, queryParams ?? <String, String>{}),
        headers: _mergeCustomHeaders(headers ?? <String, String>{}));
    return apiResponse;
  }

  @override
  Future<http.Response> get(String url, {Map<String, String>? headers, Map<String, String>? queryParams}) async {
    // await _ensureTokenIsValid(TokenManager.instance);

    http.Response apiResponse = await _client.get(prepareUrl(url, queryParams ?? <String, String>{}),
        headers: _mergeCustomHeaders(headers ?? <String, String>{}));
    return apiResponse;
  }

  @override
  Future<http.Response> post(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParams,
    payload,
  }) async {
    http.Response apiResponse = await _client.post(prepareUrl(url, queryParams ?? <String, String>{}),
        body: payload != null ? jsonEncode(payload) : null,
        headers: _mergeCustomHeaders(headers ?? <String, String>{}));
    return apiResponse;
  }

  @override
  Future<http.Response> put(String url,
      {Map<String, String>? headers, Map<String, String>? queryParams, payload}) async {
    http.Response apiResponse = await _client.put(prepareUrl(url, queryParams ?? <String, String>{}),
        body: payload != null ? jsonEncode(payload) : null,
        headers: _mergeCustomHeaders(headers ?? <String, String>{}));
    return apiResponse;
  }

  // static refreshAuthHeader(String newToken) {
  //   defaultHeaders['x-auth-token'] = newToken;
  // }

  void initDefaultHeaders(String? token) async {
    defaultHeaders['Accept'] = 'application/json';
    defaultHeaders['Content-Type'] = 'application/json';
    if (token != null) {
      defaultHeaders['x-auth-token'] = token;
    }
  }

  Map<String, String> _mergeCustomHeaders(Map<String, String> customHeaders) {
    return <String, String>{
      ...NetworkManager.defaultHeaders,
      ...customHeaders,
    };
  }

  Uri prepareUrl(String url, Map<String, String> queryParams) {
    Uri uri = Uri.parse(baseUrl + url);
    uri = uri.replace(queryParameters: queryParams);
    return uri;
  }

  @override
  String getImagePath(String? imageName) {
    if (imageName == null) return "";
    return baseUrl + Urls.file + imageName;
  }
}
