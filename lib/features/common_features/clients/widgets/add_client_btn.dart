import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';

class AddClientBtn extends StatelessWidget {
  const AddClientBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "add_client",
      backgroundColor: AppColors.accent1Shade1,
      child: const Icon(Icons.add),
      onPressed: () => RoutingManager.router
          .pushNamed(RoutingManager.deligateCreateClientScreen),
    );
  }
}
