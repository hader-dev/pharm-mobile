import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/notification/cubit/notifications_cubit.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class HomeAppBar extends StatelessWidget {
  final bool isExtraLargeScreen;
  const HomeAppBar({super.key, required this.isExtraLargeScreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: context.responsiveAppSizeTheme.current.p8,
          horizontal: context.responsiveAppSizeTheme.current.p8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom: BorderSide(color: StrokeColors.normal.color, width: .5)),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            DrawableAssetStrings.logoImg,
            width: 35,
            height: 35,
          ),
          ResponsiveGap.s4(),
          Text(
            context.translation!.app_name_2,
            style: context.responsiveTextTheme.current.headLine3SemiBold
                .copyWith(color: AppColors.accent1Shade1),
          ),
          Spacer(),
          BlocBuilder<NotificationsCubit, NotificationState>(
            builder: (context, state) {
              return context.read<NotificationsCubit>().unreadCount == 0
                  ? InkWell(
                      onTap: () => RoutingManager.router
                          .pushNamed(RoutingManager.notificationsScreen),
                      child: Icon(
                        Iconsax.notification,
                        color: AppColors.accent1Shade1,
                        size: context.deviceSize.width <=
                                DeviceSizes.largeMobile.width
                            ? context.responsiveAppSizeTheme.current.iconSize30
                            : context.responsiveAppSizeTheme.current.iconSize18,
                      ),
                    )
                  : Badge.count(
                      count: context.read<NotificationsCubit>().unreadCount,
                      child: InkWell(
                        onTap: () => RoutingManager.router
                            .pushNamed(RoutingManager.notificationsScreen),
                        child: Icon(
                          Iconsax.notification,
                          color: AppColors.accent1Shade1,
                          size: context.deviceSize.width <=
                                  DeviceSizes.largeMobile.width
                              ? context
                                  .responsiveAppSizeTheme.current.iconSize30
                              : context
                                  .responsiveAppSizeTheme.current.iconSize18,
                        ),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
