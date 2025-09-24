import 'package:flutter/widgets.dart';
import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:iconsax/iconsax.dart';

List<BottomNavigationBarItem> deligateNavbarItems(
        AppLocalizations translation) =>
    <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizesManager.p6),
          child: Icon(Iconsax.activity),
        ),
        label: translation.client,
      ),
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizesManager.p6),
          child: Icon(Iconsax.brifecase_tick),
        ),
        label: translation.order,
      ),
      BottomNavigationBarItem(
        icon: Padding(
            padding: EdgeInsets.symmetric(vertical: AppSizesManager.p6),
            child: Icon(Iconsax.profile_circle)),
        label: translation.account,
      ),
    ];
