import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/extensions/app_context_helper.dart';
import '../../cubit/app_layout_cubit.dart';

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
              selectedIndex: BlocProvider.of<AppLayoutCubit>(context).pageIndex,
            ),
          ],
        ),
        BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: context.theme.primaryColor,
          unselectedItemColor: TextColors.secondary.color,
          currentIndex: BlocProvider.of<AppLayoutCubit>(context).pageIndex,
          selectedLabelStyle: AppTypography.bodyXSmallStyle,
          unselectedLabelStyle: AppTypography.bodyXSmallStyle,
          showSelectedLabels: true,
          onTap: (index) {
            BlocProvider.of<AppLayoutCubit>(context).changePage(index);
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.symmetric(vertical: AppSizesManager.p6), child: Icon(Iconsax.home)),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.symmetric(vertical: AppSizesManager.p6), child: Icon(Iconsax.shop)),
              label: 'MarketPlace',
            ),
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.symmetric(vertical: AppSizesManager.p6), child: Icon(Iconsax.activity)),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSizesManager.p6), child: Icon(Iconsax.element_plus)),
              label: 'Applications',
            ),
            BottomNavigationBarItem(
              icon:
                  Padding(padding: EdgeInsets.symmetric(vertical: AppSizesManager.p6), child: Icon(Iconsax.setting_2)),
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
