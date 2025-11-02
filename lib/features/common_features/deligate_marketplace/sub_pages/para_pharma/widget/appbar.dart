import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/app_layout/cubit/app_layout_cubit.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class MarketplaceAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isExtraLargeScreen;

  const MarketplaceAppbar({
    super.key,
    required this.isExtraLargeScreen,
  });

  @override
  Widget build(BuildContext context) {
    final offset = context.deviceSize.width <= DeviceSizes.largeMobile.width
        ? Offset(7, -9)
        : Offset(-15, 5);

    return CustomAppBarV2.alternate(
      topPadding: MediaQuery.of(context).padding.top,
      bottomPadding: MediaQuery.of(context).padding.bottom,
      leading: IconButton(
        icon: Icon(
          Iconsax.shop,
          color: Colors.white,
          size: context.responsiveAppSizeTheme.current.iconSize25,
        ),
        onPressed: () {},
      ),
      title: Text(
        context.translation!.market_place,
        style: context.responsiveTextTheme.current.headLine3SemiBold.copyWith(
          color: Colors.white,
        ),
      ),
      trailing: [
        IconButton(
          icon: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return Badge.count(
                  count: state.cartItems.length,
                  textStyle: context.responsiveTextTheme.current.body3Medium,
                  offset: offset,
                  child: Icon(
                    Iconsax.bag_2,
                    color: Colors.white,
                    size: context.responsiveAppSizeTheme.current.iconSize25,
                  ));
            },
          ),
          onPressed: () {
            AppLayout.appLayoutScaffoldKey.currentContext!
                .read<AppLayoutCubit>()
                .changePage(2);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(isExtraLargeScreen ? kToolbarHeight * 2 : kToolbarHeight);
}
