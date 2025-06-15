import 'package:dio/dio.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/token_manager.dart';

import '../../network_interface.dart';

class TokenCheckerInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    try {
      if (err.response?.statusCode == 401) {
        await getItInstance.get<TokenManager>().refreshToken(getItInstance.get<INetworkService>());
        err.requestOptions.headers[TokenManager.tokenHeaderKey] = ' Bearer ${getItInstance.get<TokenManager>().token}';

        var client = getItInstance.get<INetworkService>().getClientInstance();
        final Response response = await (client as Dio).fetch(err.requestOptions);
        return handler.resolve(response);
      }
      return handler.next(err);
    } catch (e) {
      await getItInstance.get<TokenManager>().removeToken();
      RoutingManager.rootNavigatorKey.currentState!.pushReplacementNamed(RoutingManager.loginScreen);
      return handler.reject(err);
    }
  }
}
