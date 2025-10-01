import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';

class CreateOrderButton extends StatelessWidget {
  const CreateOrderButton({super.key});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => RoutingManager.router
          .pushNamed(RoutingManager.deligateCreateOrderScreen),
      backgroundColor: AppColors.accent1Shade1,
      child: const Icon(Icons.add),
    );
  }
}
