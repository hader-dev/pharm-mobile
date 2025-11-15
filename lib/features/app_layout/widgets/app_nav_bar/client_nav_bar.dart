import 'package:flutter/material.dart' show Badge, Colors;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart' show AppColors;
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart' show AppLayout;
import 'package:hader_pharm_mobile/features/app_layout/cubit/app_layout_cubit.dart' show AppLayoutCubit;
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart' show CartCubit, CartState;
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

List<BottomNavigationBarItem> clientNavbarItems(AppLocalizations translation, BuildContext context) =>
    <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.symmetric(vertical: context.responsiveAppSizeTheme.current.p6),
          child: generateBottomSvgIcon(
              context, DrawableAssetStrings.newHomeIcon, context.read<AppLayoutCubit>().pageIndex == 0),
        ),
        label: translation.home,
      ),
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.symmetric(vertical: context.responsiveAppSizeTheme.current.p6),
          child: generateBottomSvgIcon(
              context, DrawableAssetStrings.newMarketIcon, context.read<AppLayoutCubit>().pageIndex == 1),
        ),
        label: translation.market_place,
      ),
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.symmetric(vertical: context.responsiveAppSizeTheme.current.p6),
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return AppLayout.appLayoutScaffoldKey.currentContext!.read<CartCubit>().state.cartItems.isEmpty
                  ? generateBottomSvgIcon(
                      context, DrawableAssetStrings.newEmptyCartIcon, context.read<AppLayoutCubit>().pageIndex == 2)
                  : Badge.count(
                      count: state.cartItems.length,
                      offset: Offset(11, -10),
                      child: generateBottomSvgIcon(context, DrawableAssetStrings.newFilledCartIcon,
                          context.read<AppLayoutCubit>().pageIndex == 2),
                    );
            },
          ),
        ),
        label: translation.cart,
      ),
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.symmetric(vertical: context.responsiveAppSizeTheme.current.p6),
          child: generateBottomSvgIcon(
              context, DrawableAssetStrings.newOrderBoxIcon, context.read<AppLayoutCubit>().pageIndex == 3),
        ),
        label: translation.orders,
      ),
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.symmetric(vertical: context.responsiveAppSizeTheme.current.p6),
          child: generateBottomSvgIcon(
              context, DrawableAssetStrings.newProfileIcon, context.read<AppLayoutCubit>().pageIndex == 4),
        ),
        label: translation.profile,
      ),
    ];

SvgPicture generateBottomSvgIcon(BuildContext context, String svgPath, bool isSelected) => SvgPicture.asset(
      svgPath,
      height: context.responsiveAppSizeTheme.current.iconSize20,
      width: context.responsiveAppSizeTheme.current.iconSize20,
      colorFilter: ColorFilter.mode(
        isSelected ? context.theme.primaryColor : Colors.grey,
        BlendMode.srcIn,
      ),
    );
