import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/token_manager.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';

import '../../../../../utils/enums.dart';
import '../../network_interface.dart';

class TokenCheckerInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    try {
      if (err.response?.statusCode == 401 && err.response?.data["code"] == ApiErrorCodes.TOKEN_EXPIRED.label) {
        await getItInstance.get<TokenManager>().refreshToken(getItInstance.get<INetworkService>());
        err.requestOptions.headers[TokenManager.tokenHeaderKey] = ' Bearer ${getItInstance.get<TokenManager>().token}';

        var client = getItInstance.get<INetworkService>().getClientInstance();
        final Response response = await (client as Dio).fetch(err.requestOptions);
        return handler.resolve(response);
      }
      return handler.next(err);
    } catch (e) {
      await getItInstance.get<TokenManager>().removeToken();
      getItInstance
          .get<ToastManager>()
          .showToast(type: ToastType.error, message: "Session expired. Please login again.");
      RoutingManager.rootNavigatorKey.currentContext!.pushReplacementNamed(RoutingManager.loginScreen);

      return handler.reject(err);
    }
  }
}
