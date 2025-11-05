import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/notification/cubit/notifications_cubit.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isExtraLargeScreen;
  const HomeAppbar({super.key, required this.isExtraLargeScreen});

  @override
  Size get preferredSize => Size.fromHeight(
      isExtraLargeScreen ? kToolbarHeight * 2 : kToolbarHeight * 1.5);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.accent1Shade2,
      child: Padding(
        padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  DrawableAssetStrings.logoImgWhite,
                  width: 30,
                  height: 30,
                ),
                Text(
                  context.translation!.app_name_2,
                  style: context.responsiveTextTheme.current.headLine3SemiBold
                      .copyWith(color: Colors.white),
                ),
                const Spacer(),
                BlocBuilder<NotificationsCubit, NotificationState>(
                  builder: (context, state) {
                    return IconButton(
                      iconSize: context.deviceSize.width <=
                              DeviceSizes.largeMobile.width
                          ? context.responsiveAppSizeTheme.current.iconSize30
                          : context.responsiveAppSizeTheme.current.iconSize20,
                      onPressed: () => RoutingManager.router
                          .pushNamed(RoutingManager.notificationsScreen),
                      icon: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const Icon(
                            Iconsax.notification,
                            color: Colors.white,
                          ),
                          if (context.read<NotificationsCubit>().unreadCount >
                              0)
                            Positioned(
                              top: -4,
                              right: -4,
                              child: CircleAvatar(
                                radius: context.responsiveAppSizeTheme.current
                                    .commonWidgetsRadius,
                                backgroundColor: Colors.red,
                              ),
                            )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            const ResponsiveGap.s12(),
          ],
        ),
      ),
    );
  }
}

class HomeAppbarOld extends StatelessWidget {
  const HomeAppbarOld({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return CustomAppBar(
      bgColor: AppColors.bgWhite,
      topPadding: MediaQuery.of(context).padding.top,
      bottomPadding: MediaQuery.of(context).padding.bottom,
      leading: IconButton(
        icon: Icon(
          Iconsax.home,
          size: context.responsiveAppSizeTheme.current.iconSize18,
        ),
        onPressed: () {},
      ),
      title: Text(
        translation.home,
        style: context.responsiveTextTheme.current.headLine3SemiBold,
      ),
      trailing: [
        IconButton(
          icon: const Icon(Iconsax.notification),
          onPressed: () {},
        ),
      ],
    );
  }
}
