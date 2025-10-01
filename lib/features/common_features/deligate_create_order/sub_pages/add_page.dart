import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/cubit/create_order_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/widgets/client_selector.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/widgets/product_selector.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

class DeligateAddOrderItemsPage extends StatelessWidget {
  const DeligateAddOrderItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DeligateCreateOrderCubit>();

    return Padding(
      padding: const EdgeInsets.all(AppSizesManager.p8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderClientSelector(
            onChanged: (value) =>
                value != null ? cubit.updateClient(value) : null,
          ),
          const Divider(
            color: AppColors.accent1Shade1,
          ),
          const Expanded(child: OrderProductSelector()),
        ],
      ),
    );
  }
}
