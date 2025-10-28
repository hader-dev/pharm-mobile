import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/app_layout/widgets/app_nav_bar/deligate_nav_bar.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_marketplace/cubit/marketplace_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_marketplace/cubit/marketplace_state.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class DeligateMarketplaceNavBar extends StatelessWidget {
  const DeligateMarketplaceNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final items = deligateMartketPlaceNavbarItems(context.translation!);

    return BlocBuilder<DeligateMarketplaceCubit, DeligateMarketplaceState>(
        builder: (context, state) {
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
                selectedIndex: state.pageIndex,
              ),
            ],
          ),
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: context.theme.primaryColor,
            unselectedItemColor: TextColors.secondary.color,
            currentIndex: state.pageIndex,
            selectedLabelStyle: context.responsiveTextTheme.current.bodyXSmall,
            unselectedLabelStyle:
                context.responsiveTextTheme.current.bodyXSmall,
            showSelectedLabels: true,
            onTap: (index) {
              BlocProvider.of<DeligateMarketplaceCubit>(context)
                  .changePage(index);
            },
            items: items,
          ),
        ],
      );
    });
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
