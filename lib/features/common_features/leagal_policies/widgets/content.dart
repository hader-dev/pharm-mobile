import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/leagal_policies/state/cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

class PrivacyPolicyContent extends StatelessWidget {
  const PrivacyPolicyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LegalPolicyCubit, LegalPolicyState>(
      builder: (bcontext, state) {
        if (state is LegalPolicyLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is LegalPolicyLoadingFailed || state.legalPolicy.isEmpty) {
          return const Center(child: EmptyListWidget());
        }

        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p4),
            child: Markdown(
              data: state.legalPolicy,
            ));
      },
    );
  }
}
