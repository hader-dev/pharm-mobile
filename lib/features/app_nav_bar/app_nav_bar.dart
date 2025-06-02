import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          children: [
            Divider(
              color: Colors.grey.shade300,
              height: 0,
              thickness: 1,
            ),
            NavBarIndicator(
              tapsCount: 5,
              selectedIndex: 0,
            ),
          ],
        ),
        BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: context.theme.primaryColor,
          unselectedItemColor: Colors.black87,
          currentIndex: 0,
          showSelectedLabels: true,
          onTap: (index) {},
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.symmetric(vertical: AppSizesManager.p8), child: Icon(Iconsax.home)),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.symmetric(vertical: AppSizesManager.p8), child: Icon(Iconsax.shop)),
              label: 'MarketPlace',
            ),
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.symmetric(vertical: AppSizesManager.p8), child: Icon(Iconsax.activity)),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSizesManager.p8), child: Icon(Iconsax.element_plus)),
              label: 'Applications',
            ),
            BottomNavigationBarItem(
              icon:
                  Padding(padding: EdgeInsets.symmetric(vertical: AppSizesManager.p8), child: Icon(Iconsax.setting_2)),
              label: 'Settings',
            ),
          ],
        ),
      ],
    );
  }
}

class NavBarIndicator extends StatelessWidget {
  final int tapsCount;
  final int selectedIndex;
  const NavBarIndicator({super.key, this.tapsCount = 0, this.selectedIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ...List.generate(tapsCount, (index) {
        return Container(
          color: selectedIndex == index ? context.theme.primaryColor : Colors.transparent,
          width: MediaQuery.sizeOf(context).width / tapsCount,
          height: 3,
        );
      })
    ]);
  }
}
