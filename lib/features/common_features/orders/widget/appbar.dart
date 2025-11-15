import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/cubit/orders_cubit.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart' show DrawableAssetStrings;
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class OrdersAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isExtraLargeScreen;
  const OrdersAppBar({
    super.key,
    required this.isExtraLargeScreen,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBarV2.alternate(
      topPadding: MediaQuery.of(context).padding.top,
      bottomPadding: MediaQuery.of(context).padding.bottom,
      leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p8),
          child: SvgPicture.asset(DrawableAssetStrings.newOrderBoxIcon,
              height: context.responsiveAppSizeTheme.current.iconSize20,
              width: context.responsiveAppSizeTheme.current.iconSize20,
              colorFilter: ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ))),
      title: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          return RichText(
            text: TextSpan(
              text: context.translation!.orders,
              style: context.responsiveTextTheme.current.headLine3SemiBold.copyWith(color: AppColors.bgWhite),
              children: [
                TextSpan(
                    text: " (${state.totalItemsCount})",
                    style: context.responsiveTextTheme.current.bodySmall
                        .copyWith(color: AppColors.accent1Shade2Deemphasized)),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(isExtraLargeScreen ? kToolbarHeight * 2 : kToolbarHeight);
}
