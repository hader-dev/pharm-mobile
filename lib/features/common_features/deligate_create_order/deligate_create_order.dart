import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/cubit/provider.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/sub_pages/tabs_section.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/widgets/appbar.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/widgets/submit_order.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class DeligateCreateOrderScreen extends StatelessWidget {
  const DeligateCreateOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return DeligateCreateOrderStateProvider(
      child: Scaffold(
        appBar: DeligateCreateOrderAppbar(translation: translation),
        body: const OrderDeligateTabBarSection(),
        bottomNavigationBar: const DeligateOrderSubmit(),
      ),
    );
  }
}
