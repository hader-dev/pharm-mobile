import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/token_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';

import '../../../../config/di/di.dart' show getItInstance;

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());
  init() async {
    try {
      UserManager userManager = getItInstance.get<UserManager>();
      // ignore: unused_local_variable
      String? userAccessToken = await getItInstance.get<TokenManager>().getAccessToken();
      await userManager.getMe();
      if (!userManager.currentUser.isActive) {
        getItInstance.get<ToastManager>().showToast(
            type: ToastType.error,
            message: RoutingManager.rootNavigatorKey.currentContext!.translation!.account_not_active);
        emit(UserNotLoggedInYet());
        return;
      }
      emit(SplashCompleted());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(SplashFailed());
    }
  }
}
