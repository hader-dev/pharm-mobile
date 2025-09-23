import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/app_layout/cubit/app_layout_cubit.dart';
import 'package:hader_pharm_mobile/features/app_layout/widgets/app_nav_bar/client_nav_bar.dart';
import 'package:hader_pharm_mobile/features/app_layout/widgets/app_nav_bar/deligate_nav_bar.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final items = UserManager.instance.currentUser.role.isDelegate
        ? deligateNavbarItems(context.translation!)
        : clientNavbarItems(context.translation!);

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
              tapsCount: items.length,
              selectedIndex: BlocProvider.of<AppLayoutCubit>(context).pageIndex,
            ),
          ],
        ),
        BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: context.theme.primaryColor,
          unselectedItemColor: TextColors.secondary.color,
          currentIndex: BlocProvider.of<AppLayoutCubit>(context).pageIndex,
          selectedLabelStyle: context.responsiveTextTheme.current.bodyXSmall,
          unselectedLabelStyle: context.responsiveTextTheme.current.bodyXSmall,
          showSelectedLabels: true,
          onTap: (index) {
            BlocProvider.of<AppLayoutCubit>(context).changePage(index);
          },
          items: items,
        ),
      ],
    );
  }
}

class NavBarIndicator extends StatelessWidget {
  final int tapsCount;
  final int selectedIndex;
  const NavBarIndicator(
      {super.key, this.tapsCount = 0, this.selectedIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ...List.generate(tapsCount, (index) {
        return Container(
          color: selectedIndex == index
              ? context.theme.primaryColor
              : Colors.transparent,
          width: MediaQuery.sizeOf(context).width / tapsCount,
          height: 3,
        );
      })
    ]);
  }
}
