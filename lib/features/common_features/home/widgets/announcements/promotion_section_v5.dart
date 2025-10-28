import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/promotion_item_widget_4.dart';
import 'package:hader_pharm_mobile/features/common_features/home/cubit/home_cubit.dart';
import 'package:hader_pharm_mobile/models/announcement.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/responsive/silver_grid_params.dart';

class PromotionSectionV5 extends StatelessWidget {
  final List<AnnouncementModel> announcements;
  final PageController pageController = PageController(initialPage: 0);
  final double minSectionHeight;

  PromotionSectionV5(
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
        if (state is PromotionLoadingFailed || announcements.isEmpty) {
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
                        style: context.responsiveTextTheme.current.body3Regular
                            .copyWith(
                          color: AppColors.accent1Shade1,
                        ),
                      ),
                    ),
                  ],
                ),
                const ResponsiveGap.s8(),
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    return GridView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing:
                            calculateMarketplaceGridSpacing(context.deviceSize),
                        mainAxisSpacing: calculateMarketplaceMainAxisSpacing(
                            context.deviceSize),
                        childAspectRatio: calculateAllAnnouncementsAspectRatio(
                            context.deviceSize, context.orientation),
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: announcements.length,
                      itemBuilder: (ctx, index) => PromotionItemWidget4(
                        announcement: announcements[index],
                        onTap: (announcement) => RoutingManager.router
                            .pushNamed(RoutingManager.announcementDetailsScreen,
                                extra: announcement.id),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
