import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common_features/leagal_policies/state/state_provider.dart';
import 'package:hader_pharm_mobile/features/common_features/leagal_policies/widgets/appbar.dart';
import 'package:hader_pharm_mobile/features/common_features/leagal_policies/widgets/content.dart';

import '../../../utils/constants.dart';

class LegalPoliciesScreen extends StatelessWidget {
  const LegalPoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StateProvider(
      child: Scaffold(
        appBar: PolicyAppbar(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: AppSizesManager.p8,
              right: AppSizesManager.p8,
              bottom: AppSizesManager.p8,
            ),
            child: Column(
              children: <Widget>[
                Expanded(child: PrivacyPolicyContent()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
