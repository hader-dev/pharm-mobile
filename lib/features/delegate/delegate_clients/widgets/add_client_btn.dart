import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';

class AddNewClientBtn extends StatelessWidget {
  const AddNewClientBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      heroTag: "add_client",
      backgroundColor: AppColors.accent1Shade1,
      child: const Icon(Icons.add),
      onPressed: () => RoutingManager.router.pushNamed(RoutingManager.delegateCreateClientScreen),
    );
  }
}
