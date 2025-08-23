import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// An interceptor for [Dio] that injects and persists cookies using a [CookieJar].
///
/// [CustomCookieInjector] sends cookies from the [CookieJar] with each request
///  [appBaseUrl], used as folder name to  stores cookies from responses for future use.
///
///  Cookies are retrieved using [CookieJar.loadForRequest]
/// and saved using [CookieJar.saveFromResponse].
///
/// Typically used in conjunction with [DioNetworkManager].
class CustomCookieInjector extends Interceptor {
  final _setCookieReg = RegExp('(?<=)(,)(?=[^;]+?=)');
  final String appBaseUrl;
  final CookieJar cookieJar;

  CustomCookieInjector(
    this.cookieJar,
    this.appBaseUrl,
  );
  String getCookies(List<Cookie> cookies) {
    // Sort cookies by path (longer path first).
    cookies.sort((a, b) {
      if (a.path == null && b.path == null) {
        return 0;
      } else if (a.path == null) {
        return -1;
      } else if (b.path == null) {
        return 1;
      } else {
        return b.path!.length.compareTo(a.path!.length);
      }
    });
    return cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      var cookies = await cookieJar.loadForRequest(Uri.parse(appBaseUrl));
      debugPrint('cookies: $cookies');
      final newCookies = getCookies([
        ...cookies,
      ]);
      options.headers[HttpHeaders.cookieHeader] =
          newCookies.isNotEmpty ? newCookies : null;
      handler.next(options);
    } catch (e, s) {
      final error = DioException(
        requestOptions: options,
        error: e,
        stackTrace: s,
      );
      handler.reject(error, true);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _saveCookies(response).then((_) => handler.next(response)).catchError(
      (dynamic e, StackTrace s) {
        final error = DioException(
          requestOptions: response.requestOptions,
          error: e,
          stackTrace: s,
        );
        handler.reject(error, true);
      },
    );
  }

  Future<void> _saveCookies(Response response) async {
    Uri cookieJarFolderUri = Uri.parse(appBaseUrl);
    final setCookies = response.headers[HttpHeaders.setCookieHeader];
    if (setCookies == null || setCookies.isEmpty) {
      return;
    }
    final List<Cookie> cookies = setCookies
        .map((str) => str.split(_setCookieReg))
        .expand((cookie) => cookie)
        .where((cookie) => cookie.isNotEmpty)
        .map((str) => Cookie.fromSetCookieValue(str))
        .toList();
    await cookieJar.delete(cookieJarFolderUri);
    await cookieJar.saveFromResponse(cookieJarFolderUri, cookies);
  }
}
