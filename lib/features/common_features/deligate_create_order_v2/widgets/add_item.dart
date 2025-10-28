import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';

class AddItemButton extends StatelessWidget {
  const AddItemButton({super.key});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => {},
      backgroundColor: AppColors.accent1Shade1,
      child: const Icon(Icons.add),
    );
  }
}
