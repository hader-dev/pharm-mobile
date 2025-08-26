import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common_features/leagal_policies/state/cubit.dart';
import 'package:hader_pharm_mobile/repositories/locale/privacy_policy/privacy_policy_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class StateProvider extends StatelessWidget {
  final Widget child;

  const StateProvider({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    final locale = context.translation!.localeName;

    return BlocProvider<LegalPolicyCubit>(
      create: (bContext) => LegalPolicyCubit(
        privacyPolicyRepository: PrivacyPolicyRepositoryImpl(),
        locale: locale,
      )..getPrivacyPolicy(),
      child: child,
    );
  }
}
