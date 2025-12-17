import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/actions/navigate_back.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/cubit/orders_details_cubit.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lucide_icons/lucide_icons.dart' show LucideIcons;

import '../cubit/order_details/orders_details_cubit.dart' show DelegateOrderDetails2Cubit, DelegateOrdersDetails2State;

class DelegateOrderDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DelegateOrderDetailsAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<PopupMenuButtonState<String>> menuKey = GlobalKey<PopupMenuButtonState<String>>();
    return CustomAppBarV2.normal(
      topPadding: MediaQuery.of(context).padding.top,
      bottomPadding: MediaQuery.of(context).padding.bottom,
      leading: IconButton(
        icon: Icon(Directionality.of(context) == TextDirection.rtl ? Iconsax.arrow_right_3 : Iconsax.arrow_left_2,
            size: context.responsiveAppSizeTheme.current.iconSize25, color: AppColors.accent1Shade1),
        onPressed: () => handleNavigateBack(context),
      ),
      title: Row(
        children: [
          Icon(Iconsax.box_2, size: context.responsiveAppSizeTheme.current.iconSize25, color: AppColors.accent1Shade1),
          const ResponsiveGap.s12(),
          Expanded(
            child: Text(
              context.translation!.order_details,
              style: context.responsiveTextTheme.current.headLine3SemiBold.copyWith(color: AppColors.accent1Shade1),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      trailing: [
        BlocBuilder<DelegateOrderDetails2Cubit, DelegateOrdersDetails2State>(
          builder: (context, state) {
            if (state is OrderDetailsLoading) {
              return SizedBox.shrink();
            }
            return PopupMenuButton<String>(
              key: menuKey,
              offset: const Offset(0, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
              ),
              onSelected: (value) {
                context.read<DelegateOrderDetails2Cubit>().onMenuOptionSelected(
                      value,
                      context.read<DelegateOrderDetails2Cubit>().state.orderData,
                    );
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: "orderTracking",
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.history,
                        size: context.responsiveAppSizeTheme.current.iconSize20,
                        color: AppColors.accent1Shade1,
                      ),
                      ResponsiveGap.s8(),
                      Text(
                        context.translation!.order_tracking,
                      ),
                    ],
                  ),
                ),
              ],
              child: InkWell(
                onTap: () => menuKey.currentState?.showButtonMenu(),
                child: Padding(
                  padding: EdgeInsets.only(right: context.responsiveAppSizeTheme.current.p16),
                  child: Icon(
                    LucideIcons.moreVertical,
                    color: AppColors.accent1Shade1,
                    size: context.responsiveAppSizeTheme.current.iconSize20,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
