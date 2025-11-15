import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:hader_pharm_mobile/features/app_layout/cubit/app_layout_cubit.dart' show AppLayoutCubit;
import 'package:hader_pharm_mobile/features/app_layout/widgets/app_nav_bar/client_nav_bar.dart'
    show generateBottomSvgIcon;
import 'package:hader_pharm_mobile/utils/assets_strings.dart' show DrawableAssetStrings;
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

List<BottomNavigationBarItem> deligateNavbarItems(AppLocalizations translation, BuildContext context) =>
    <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.symmetric(vertical: context.responsiveAppSizeTheme.current.p6),
          child: generateBottomSvgIcon(
              context, DrawableAssetStrings.newClientsIcon, context.read<AppLayoutCubit>().pageIndex == 0),
        ),
        label: translation.client,
      ),
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.symmetric(vertical: context.responsiveAppSizeTheme.current.p6),
          child: generateBottomSvgIcon(
              context, DrawableAssetStrings.newOrderBoxIcon, context.read<AppLayoutCubit>().pageIndex == 1),
        ),
        label: translation.orders,
      ),
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.symmetric(vertical: context.responsiveAppSizeTheme.current.p6),
          child: generateBottomSvgIcon(
              context, DrawableAssetStrings.newMarketIcon, context.read<AppLayoutCubit>().pageIndex == 2),
        ),
        label: translation.market_place,
      ),
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.symmetric(vertical: context.responsiveAppSizeTheme.current.p6),
          child: generateBottomSvgIcon(
              context, DrawableAssetStrings.newProfileIcon, context.read<AppLayoutCubit>().pageIndex == 3),
        ),
        label: translation.profile,
      ),
    ];

List<BottomNavigationBarItem> deligateMartketPlaceNavbarItems(AppLocalizations translation, BuildContext context) =>
    <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.symmetric(vertical: context.responsiveAppSizeTheme.current.p6),
          child: Icon(
            Iconsax.shop,
            size: context.responsiveAppSizeTheme.current.iconSize25,
          ),
        ),
        label: translation.market_place,
      ),
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.symmetric(vertical: context.responsiveAppSizeTheme.current.p6),
          child: Icon(
            Iconsax.bag_2,
            size: context.responsiveAppSizeTheme.current.iconSize25,
          ),
        ),
        label: translation.cart,
      ),
    ];
