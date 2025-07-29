import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/token_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/splash/cubit/splash_cubit.dart';
import 'package:hader_pharm_mobile/models/jwt_decoded.dart';
import 'package:hader_pharm_mobile/utils/login_jwt_decoder.dart';


void setupCompanyOrGoHome(BuildContext context, SplashState state) {
  if (state is UserNotLoggedInYet || state is SplashFailed) {
    GoRouter.of(context).pushReplacementNamed(RoutingManager.loginScreen);
  }
  if (state is SplashCompleted) {
    JwtDecoded decodedJwt =
        decodeJwt(getItInstance.get<TokenManager>().token ?? "");

    bool shouldSetupCompanyProfile =
        decodedJwt.companyId == null || decodedJwt.companyId == "null";

    if (shouldSetupCompanyProfile) {
      context.pushReplacementNamed(RoutingManager.createCompanyProfile);
      return;
    }

    GoRouter.of(context).pushReplacementNamed(RoutingManager.appLayout);
  }
}
