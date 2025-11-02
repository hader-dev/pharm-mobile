import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/cubit/create_order_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/widgets/client_selector.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/widgets/product_selector.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class DeligateAddOrderItemsPage extends StatelessWidget {
  const DeligateAddOrderItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DeligateCreateOrderCubit>();
    final translation = context.translation!;

    return Padding(
      padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            translation.client,
            style:
                context.responsiveTextTheme.current.headLine3Medium.copyWith(),
          ),
          const ResponsiveGap.s4(),
          OrderClientSelector(
            onChanged: (value) =>
                value != null ? cubit.updateClient(value) : null,
            currentSelection: cubit.state.client,
          ),
          const ResponsiveGap.s24(),
          Text(
            translation.product,
            style:
                context.responsiveTextTheme.current.headLine3Medium.copyWith(),
          ),
          const ResponsiveGap.s4(),
          const Expanded(child: OrderProductSelector()),
        ],
      ),
    );
  }
}
