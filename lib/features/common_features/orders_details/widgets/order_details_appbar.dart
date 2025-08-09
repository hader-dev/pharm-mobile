import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/actions/navigate_back.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/cubit/orders_details_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class OrderDetailsAppbar extends StatelessWidget  implements PreferredSizeWidget {
  const OrderDetailsAppbar({
    super.key,
  });

  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return CustomAppBarV2.alternate(
      topPadding: MediaQuery.of(context).padding.top,
      bottomPadding: MediaQuery.of(context).padding.bottom,
      leading: IconButton(
        icon: Icon(
          Directionality.of(context) == TextDirection.rtl ? Iconsax.arrow_right_3 : Iconsax.arrow_left_2,
          size: AppSizesManager.iconSize25,
          color: AppColors.bgWhite
        ),
        onPressed: () => handleNavigateBack(context),
      ),
      title: Row(
        children: [
          const Icon(
            Iconsax.box_2,
            size: AppSizesManager.iconSize25,
            color: AppColors.bgWhite
          ),
          Gap(AppSizesManager.s12),
          Text(
            context.translation!.order_details,
            style: AppTypography.headLine3SemiBoldStyle.copyWith(color: AppColors.bgWhite),
            
          ),
        ],
      ),
      trailing: [
        BlocBuilder<OrderDetailsCubit, OrdersDetailsState>(
          builder: (context, state) {
            if (state is OrderDetailsLoading) {
              return Container(
                  padding: EdgeInsets.all(AppSizesManager.p6),
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.1,
                  ));
            }
            OrderStatus orderStatus = OrderStatus.values
                .firstWhere((statusItem) => statusItem.id == context.read<OrderDetailsCubit>().orderData!.status);
            return Container(
              margin: EdgeInsets.only(right: AppSizesManager.p12),
              padding: EdgeInsets.all(AppSizesManager.p6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(AppSizesManager.r6),
                    topLeft: Radius.circular(AppSizesManager.r6)),
                color: orderStatus.color.withAlpha(50),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(OrderStatus.getTranslatedStatus(orderStatus),
                      style: AppTypography.bodySmallStyle
                          .copyWith(color: orderStatus.color, fontWeight: AppTypography.appFontSemiBold)),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}