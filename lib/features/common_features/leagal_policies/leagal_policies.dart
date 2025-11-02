import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common_features/leagal_policies/state/state_provider.dart';
import 'package:hader_pharm_mobile/features/common_features/leagal_policies/widgets/appbar.dart';
import 'package:hader_pharm_mobile/features/common_features/leagal_policies/widgets/content.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

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
              left: context.responsiveAppSizeTheme.current.p8,
              right: context.responsiveAppSizeTheme.current.p8,
              bottom: context.responsiveAppSizeTheme.current.p8,
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
