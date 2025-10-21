import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/token_manager.dart';
import 'package:hader_pharm_mobile/models/jwt_decoded.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

JwtDecoded decodeJwt(String? token) {
  Map<String, dynamic> decodedJwt = {};

  try {
    decodedJwt =
        JwtDecoder.decode(getItInstance.get<TokenManager>().token ?? "");
    debugPrint("CompanyId ${decodedJwt['companyId']}");
  } catch (e) {
    decodedJwt = {};
  }

  return JwtDecoded.fromJson(decodedJwt);
}
