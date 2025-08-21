import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/compact_custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common_features/notification/cubit/notifications_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2.5);

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return ColoredBox(
      color: AppColors.accent1Shade2,
      child: Padding(
        padding: const EdgeInsets.all(AppSizesManager.p8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Sologene",
                  style: context.responsiveTextTheme.current.headLine3SemiBold
                      .copyWith(color: Colors.white),
                ),
                const Spacer(),
                BlocBuilder<NotificationsCubit, NotificationState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: () => RoutingManager.router
                          .pushNamed(RoutingManager.notificationsScreen),
                      child: Stack(
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
                                radius: AppSizesManager.commonWidgetsRadius,
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
            Gap(AppSizesManager.s12),
            CustomAppBarV2.expanded(
              bgColor: AppColors.accent1Shade2,
              topPadding: MediaQuery.of(context).padding.top,
              bottomPadding: MediaQuery.of(context).padding.bottom,
              title: CompactCustomTextField(
                hintText: translation.vendors_search_field_hint,
                state: FieldState.normal,
                isEnabled: true,
                isFilled: true,
                prefixIcon: Icon(
                  Iconsax.search_normal,
                  color: AppColors.accent1Shade1,
                ),
                suffixIcon: Icon(
                  Icons.clear,
                  color: AppColors.accent1Shade1,
                ),
                onChanged: (searchValue) {
                  // TODO SEARCH VENDORS HOME
                },
                validationFunc: (value) {},
              ),
            ),
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
        icon: const Icon(
          Iconsax.home,
          size: AppSizesManager.iconSize25,
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
