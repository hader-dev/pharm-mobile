import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/promotion_item_widget_3.dart';
import 'package:hader_pharm_mobile/features/common_features/home/cubit/home_cubit.dart';
import 'package:hader_pharm_mobile/models/announcement.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
        if (state is PromotionLoadingFailed || announcements.isEmpty) {
          return Center(
            child: EmptyListWidget(),
          );
        }

        return Padding(
          padding: EdgeInsets.only(
            right: context.responsiveAppSizeTheme.current.p8,
            left: context.responsiveAppSizeTheme.current.p8,
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
                Column(
                  children: <Widget>[
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(context
                              .responsiveAppSizeTheme
                              .current
                              .commonWidgetsRadius)),
                      height: minSectionHeight * 1.75,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: LayoutBuilder(builder: (context, constraints) {
                        return PageView(
                          controller: pageController,
                          scrollDirection: Axis.horizontal,
                          children: announcements
                              .map((AnnouncementModel announcement) =>
                                  PromotionItemWidget3(
                                    announcement: announcement,
                                    onTap: (announcement) =>
                                        RoutingManager.router.pushNamed(
                                            RoutingManager
                                                .announcementDetailsScreen,
                                            extra: announcement.id),
                                  ))
                              .toList(),
                        );
                      }),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(context
                            .responsiveAppSizeTheme
                            .current
                            .commonWidgetsRadius),
                      ),
                      padding: EdgeInsets.all(
                          context.responsiveAppSizeTheme.current.p4),
                      margin: EdgeInsets.all(
                          context.responsiveAppSizeTheme.current.p4),
                      child: SmoothPageIndicator(
                        controller: pageController,
                        effect: const ExpandingDotsEffect(
                          dotHeight: 4,
                          dotWidth: 4,
                          spacing: 2,
                          dotColor: Colors.grey,
                          activeDotColor: Colors.white,
                        ),
                        count: announcements.length,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
