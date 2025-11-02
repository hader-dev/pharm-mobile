import 'package:flutter/widgets.dart';
import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

List<BottomNavigationBarItem> clientNavbarItems(
        AppLocalizations translation, BuildContext context) =>
    <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.symmetric(
              vertical: context.responsiveAppSizeTheme.current.p6),
          child: Icon(
            Iconsax.home,
            size: context.responsiveAppSizeTheme.current.iconSize25,
          ),
        ),
        label: translation.home,
      ),
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.symmetric(
              vertical: context.responsiveAppSizeTheme.current.p6),
          child: Icon(
            Iconsax.shop,
            size: context.responsiveAppSizeTheme.current.iconSize25,
          ),
        ),
        label: translation.market_place,
      ),
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.symmetric(
              vertical: context.responsiveAppSizeTheme.current.p6),
          child: Icon(
            Iconsax.bag_2,
            size: context.responsiveAppSizeTheme.current.iconSize25,
          ),
        ),
        label: translation.cart,
      ),
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.symmetric(
              vertical: context.responsiveAppSizeTheme.current.p6),
          child: Icon(
            Iconsax.box,
            size: context.responsiveAppSizeTheme.current.iconSize25,
          ),
        ),
        label: translation.orders,
      ),
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.symmetric(
              vertical: context.responsiveAppSizeTheme.current.p6),
          child: Icon(
            Iconsax.profile_circle,
            size: context.responsiveAppSizeTheme.current.iconSize25,
          ),
        ),
        label: translation.account,
      ),
    ];
