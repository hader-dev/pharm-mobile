import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/token_manager.dart';
import 'package:hader_pharm_mobile/models/jwt_decoded.dart';
import 'package:hader_pharm_mobile/utils/login_jwt_decoder.dart';

bool doesUserBelongsToCompany() {
  final token = getItInstance.get<TokenManager>().token;

  debugPrint("meowTOken $token");

  if (token != null) {
    JwtDecoded decodedJwt = decodeJwt(token);

    bool shouldSetupCompanyProfile =
        decodedJwt.companyId == null || decodedJwt.companyId == "null";

    return !shouldSetupCompanyProfile;
  }
  return false;
}

void setupCompanyOrSkipToHome() {
  final shouldSetupCompanyProfile = !doesUserBelongsToCompany();

  if (shouldSetupCompanyProfile) {
    RoutingManager.router.goNamed(RoutingManager.createCompanyProfile);
    return;
  }

  RoutingManager.router.goNamed(RoutingManager.appLayout);
}
