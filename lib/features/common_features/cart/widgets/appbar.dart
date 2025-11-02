import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class CartAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isExtraLargeScreen;
  const CartAppbar({
    super.key,
    required this.isExtraLargeScreen,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBarV2.alternate(
      topPadding: MediaQuery.of(context).padding.top,
      bottomPadding: MediaQuery.of(context).padding.bottom,
      leading: IconButton(
        icon: Icon(
          Iconsax.bag_2,
          size: context.responsiveAppSizeTheme.current.iconSize25,
          color: AppColors.bgWhite,
        ),
        onPressed: () {},
      ),
      title: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return Text.rich(
            TextSpan(
              text: context.translation!.cart,
              style: context.responsiveTextTheme.current.headLine3SemiBold
                  .copyWith(color: AppColors.bgWhite),
              children: [
                TextSpan(
                    text: " (${state.cartItems.length})",
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
  Size get preferredSize =>
      Size.fromHeight(isExtraLargeScreen ? kToolbarHeight * 2 : kToolbarHeight);
}
