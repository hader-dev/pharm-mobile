import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/app_layout/cubit/app_layout_cubit.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class MarketplaceAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MarketplaceAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBarV2.alternate(
      topPadding: MediaQuery.of(context).padding.top,
      bottomPadding: MediaQuery.of(context).padding.bottom,
      leading: IconButton(
        icon: const Icon(
          Iconsax.shop,
          color: Colors.white,
          size: AppSizesManager.iconSize25,
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
                  offset: Offset(7, -9),
                  child: const Icon(
                    Iconsax.bag_2,
                    color: Colors.white,
                    size: 28,
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
