import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/home/cubit/home_cubit.dart';
import 'package:hader_pharm_mobile/models/announcement.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'promotion_item_widget.dart';

class PromotionSection extends StatelessWidget {
  final List<AnnouncementModel> announcements;
  final PageController pageController = PageController(initialPage: 0);
  PromotionSection(
      {super.key, this.announcements = const <AnnouncementModel>[]});

  @override
  Widget build(BuildContext context) {
    final translations = context.translation!;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, HomeState state) {
        if (state is PromotionLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is PromotionLoadingFailed) {
          return Text(
            translations.feedback_failed_to_load_announcements,
          );
        }
        return Padding(
          padding: const EdgeInsets.only(
            right: AppSizesManager.p8,
            left: AppSizesManager.p8,
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        AppSizesManager.commonWidgetsRadius)),
                height: 130,
                width: MediaQuery.of(context).size.width,
                child: PageView(
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  children: announcements
                      .map(
                        (AnnouncementModel announcement) => PromotionItemWidget(
                          announcement: announcement,
                          filterColor: AppColors.accent1Shade2,
                          onForegroundColor: Colors.white,
                          onTap: (announcement) => RoutingManager.router
                              .pushNamed(
                                  RoutingManager.announcementDetailsScreen,
                                  extra: announcement.id),
                        ),
                      )
                      .toList(),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(
                      AppSizesManager.commonWidgetsRadius),
                ),
                padding: const EdgeInsets.all(AppSizesManager.p4),
                margin: const EdgeInsets.all(AppSizesManager.p4),
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
        );
      },
    );
  }
}
