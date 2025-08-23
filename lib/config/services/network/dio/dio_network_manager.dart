import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/services/network/dio/interceptor/request_token_interceptor.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../utils/urls.dart';
import '../../auth/token_manager.dart';
import '../network_interface.dart';
import '../network_response_handler.dart';
import 'interceptor/cookies_injector_interceptor.dart';

class DioNetworkManager extends INetworkService {
  late Dio _client;
  late final PersistCookieJar cookieJar;
  static final DioNetworkManager _instance = DioNetworkManager._internal();

  static DioNetworkManager get instance {
    return _instance;
  }

  static Map<String, String> defaultHeaders = <String, String>{};

  DioNetworkManager._internal();

  init(String apiUrl, Dio client, TokenManager tokenManager) async {
    baseUrl = apiUrl.replaceAll(RegExp(r'\s+'), '');
    ;
    client.options.baseUrl = baseUrl;
    _client = client;
    await preparePersistantCookiesJar();
    _prepareInterceptors();
    String? currentToken = await tokenManager.getAccessToken();

    initDefaultHeaders(currentToken);
  }

  void _prepareInterceptors() {
    _client.interceptors.add(CustomCookieInjector(cookieJar, baseUrl));
    _client.interceptors.add(TokenCheckerInterceptor());
  }

  @override
  getClientInstance() {
    return _instance._client;
  }

  Future<void> preparePersistantCookiesJar() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    cookieJar = PersistCookieJar(
      storage: FileStorage("$appDocPath/.cookies/"),
      ignoreExpires: true,
    );
  }

  @override
  Future<dynamic> sendRequest(Function sendFunc) async {
    try {
      Response response = await sendFunc();
      var decodedResponse = ResponseHandler.processResponse(response);
      return decodedResponse;
    } on DioException catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      var decodedResponse = ResponseHandler.processResponse(e.response);
      return decodedResponse;
    }
  }

  @override
  Future<Response> patch(String url,
      {Map<String, String>? headers,
      Map<String, Object>? queryParams,
      dynamic payload}) async {
    bool isFormData = payload is FormData;
    Response apiResponse = await _client.patchUri(
        prepareUrl(url, queryParams: queryParams),
        data: payload != null
            ? isFormData
                ? payload
                : jsonEncode(payload)
            : null,
        options: Options(
            headers: _mergeCustomHeaders(headers ?? <String, String>{})));
    return apiResponse;
  }

  @override
  Future<Response> delete(String url,
      {Map<String, String>? headers,
      Map<String, Object>? queryParams,
      payload}) async {
    Response apiResponse = await _client.deleteUri(
        data: payload,
        prepareUrl(url, queryParams: queryParams),
        options: Options(
            headers: _mergeCustomHeaders(headers ?? <String, String>{})));
    return apiResponse;
  }

  @override
  Future<Response> get(String url,
      {Map<String, String>? headers, Map<String, Object>? queryParams}) async {
    // await _ensureTokenIsValid(TokenManager.instance);

    Response apiResponse = await _client.getUri(
        prepareUrl(url, queryParams: queryParams),
        options: Options(
            headers: _mergeCustomHeaders(headers ?? <String, String>{})));
    return apiResponse;
  }

  @override
  Future<Response> post(
    String url, {
    Map<String, String>? headers,
    Map<String, Object>? queryParams,
    payload,
  }) async {
    Response apiResponse = await _client.postUri(
        prepareUrl(url, queryParams: queryParams),
        data: payload != null
            ? payload is FormData
                ? payload
                : jsonEncode(payload)
            : null,
        options: Options(
            headers: _mergeCustomHeaders(headers ?? <String, String>{})));
    return apiResponse;
  }

  @override
  Future<Response> put(String url,
      {Map<String, String>? headers,
      Map<String, Object>? queryParams,
      payload}) async {
    bool isFormData = payload is FormData;
    Response apiResponse = await _client.putUri(
        prepareUrl(url, queryParams: queryParams),
        data: payload != null
            ? isFormData
                ? payload
                : jsonEncode(payload)
            : null,
        options: Options(
            headers: _mergeCustomHeaders(headers ?? <String, String>{})));
    return apiResponse;
  }

  @override
  void refreshAuthHeader(String? token) {
    if (token != null) {
      defaultHeaders[TokenManager.tokenHeaderKey] = "Bearer $token";
    }
  }

  void initDefaultHeaders(String? token) async {
    if (token != null) {
      defaultHeaders[TokenManager.tokenHeaderKey] = "Bearer $token";
    }
  }

  Map<String, String> _mergeCustomHeaders(Map<String, String> customHeaders) {
    return <String, String>{
      ...DioNetworkManager.defaultHeaders,
      ...customHeaders,
    };
  }

  Uri prepareUrl(String url, {Map<String, dynamic>? queryParams}) {
    final cleanUrl = url.replaceAll(RegExp(r'\s+'), '');

    Uri uri = Uri.parse("$baseUrl$cleanUrl");
    return queryParams == null
        ? uri
        : uri.replace(queryParameters: queryParams);
  }

  @override
  String getFilesPath(String? imageName) {
    if (imageName == null || imageName.isEmpty) return "";

    if (imageName.startsWith('/')) {
      return "$baseUrl${Urls.publicFiles}$imageName";
    } else {
      return "$baseUrl${Urls.publicFiles}/$imageName";
    }
  }
}
