import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/token_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';

class TokenCheckerInterceptor extends Interceptor {
  bool isLastRefreshTry = false;
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final data = err.response?.data;
    final isJson = data is Map<String, dynamic>;

    final isTokenError = isJson &&
        (data["code"] == ApiErrorCodes.TOKEN_EXPIRED.label ||
            data["code"] == ApiErrorCodes.NO_TOKEN.label);

    try {
      if (err.response?.statusCode == 401 &&
          isTokenError &&
          !isLastRefreshTry) {
        isLastRefreshTry = true;
        await getItInstance
            .get<TokenManager>()
            .refreshToken(getItInstance.get<INetworkService>());
        err.requestOptions.headers[TokenManager.tokenHeaderKey] =
            ' Bearer ${getItInstance.get<TokenManager>().token}';

        var client = getItInstance.get<INetworkService>().getClientInstance();
        final Response response =
            await (client as Dio).fetch(err.requestOptions);
        return handler.resolve(response);
      }
      return handler.next(err);
    } catch (e) {
      isLastRefreshTry = false;
      await getItInstance.get<TokenManager>().removeToken();
      RoutingManager.rootNavigatorKey.currentContext!
          .pushReplacementNamed(RoutingManager.loginScreen);

      return handler.reject(err);
    }
  }
}
