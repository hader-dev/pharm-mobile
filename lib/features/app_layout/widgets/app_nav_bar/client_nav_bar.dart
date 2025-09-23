import 'package:flutter/widgets.dart';
import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:iconsax/iconsax.dart';

List<BottomNavigationBarItem> clientNavbarItems(AppLocalizations translation) =>
    <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Padding(
            padding: EdgeInsets.symmetric(vertical: AppSizesManager.p6),
            child: Icon(Iconsax.home)),
        label: translation.home,
      ),
      BottomNavigationBarItem(
        icon: Padding(
            padding: EdgeInsets.symmetric(vertical: AppSizesManager.p6),
            child: Icon(Iconsax.shop)),
        label: translation.market_place,
      ),
      BottomNavigationBarItem(
        icon: Padding(
            padding: EdgeInsets.symmetric(vertical: AppSizesManager.p6),
            child: Icon(Iconsax.bag_2)),
        label: translation.cart,
      ),
      BottomNavigationBarItem(
        icon: Padding(
            padding: EdgeInsets.symmetric(vertical: AppSizesManager.p6),
            child: Icon(Iconsax.box)),
        label: translation.orders,
      ),
      BottomNavigationBarItem(
        icon: Padding(
            padding: EdgeInsets.symmetric(vertical: AppSizesManager.p6),
            child: Icon(Iconsax.profile_circle)),
        label: translation.account,
      ),
    ];
