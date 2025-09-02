import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/home/cubit/home_cubit.dart';
import 'package:hader_pharm_mobile/models/announcement.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../common/widgets/promotion_item_widget.dart';

class PromotionSection extends StatelessWidget {
  final List<AnnouncementModel> announcements;
  final PageController pageController = PageController(initialPage: 0);
  final double minSectionHeight;

  PromotionSection(
      {super.key,
      this.announcements = const <AnnouncementModel>[],
      required this.minSectionHeight});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, HomeState state) {
        if (state is PromotionLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is PromotionLoadingFailed) {
          return Center(
            child: EmptyListWidget(),
          );
        }

        if (announcements.isEmpty) {
          return Center(
            child: EmptyListWidget(),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(
            right: AppSizesManager.p8,
            left: AppSizesManager.p8,
          ),
          child: SizedBox(
            height: minSectionHeight * 2.5,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.translation!.announcements,
                      style: context.responsiveTextTheme.current.headLine2
                          .copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        RoutingManager.router.pushNamed(
                          RoutingManager.allAnnouncementsScreen,
                        );
                      },
                      child: Text(
                        context.translation!.see_all,
                        style: const TextStyle(
                          color: AppColors.accent1Shade1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const ResponsiveGap.s8(),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context,constraints) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: announcements.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: constraints.maxWidth * 0.65,
                            child: PromotionItemWidget(
                              announcement: announcements[index],
                              onTap: (announcement) => RoutingManager.router
                                  .pushNamed(
                                      RoutingManager.announcementDetailsScreen,
                                      extra: announcement.id),
                            ),
                          );
                        },
                      );
                    }
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
