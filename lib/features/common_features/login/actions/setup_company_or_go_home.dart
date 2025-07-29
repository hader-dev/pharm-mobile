import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/token_manager.dart';
import 'package:hader_pharm_mobile/models/jwt_decoded.dart';
import 'package:hader_pharm_mobile/utils/login_jwt_decoder.dart';

void setupCompanyOrSkipToHome(BuildContext context) {
  JwtDecoded decodedJwt = decodeJwt(getItInstance.get<TokenManager>().token ?? "");

  bool shouldSetupCompanyProfile = decodedJwt.companyId == null || decodedJwt.companyId =="null";


  if (shouldSetupCompanyProfile) {
    context.goNamed(RoutingManager.createCompanyProfile);
    return;
  }

  context.goNamed(RoutingManager.appLayout);
}
