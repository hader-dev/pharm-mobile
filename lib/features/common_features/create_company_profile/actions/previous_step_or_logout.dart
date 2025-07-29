import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/cubit/create_company_profile_cubit.dart';

void previousStepOrLogout(BuildContext context) {
  bool hasPreviousStep =
      BlocProvider.of<CreateCompanyProfileCubit>(context).currentStepIndex != 0;

  if (hasPreviousStep) {
    BlocProvider.of<CreateCompanyProfileCubit>(context).previousStep();
    return;
  }

  getItInstance.get<UserManager>().logout();

  GoRouter.of(context).pushReplacementNamed(RoutingManager.loginScreen);
}
