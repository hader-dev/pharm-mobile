import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/home/cubit/home_cubit.dart';
import 'package:hader_pharm_mobile/models/announcement.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart'
    show DrawableAssetStrings;
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../common/widgets/promotion_item_widget.dart'
    show PromotionItemWidget;

class PromotionSectionV6 extends StatelessWidget {
  final List<AnnouncementModel> announcements;
  final PageController pageController = PageController(initialPage: 0);

  final double minSectionHeight;

  PromotionSectionV6(
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
          padding: EdgeInsets.symmetric(
            horizontal: context.responsiveAppSizeTheme.current.p8,
          ),
          child: SizedBox(
            height: minSectionHeight * 1.2,
            child: Column(
              children: <Widget>[
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(context
                          .responsiveAppSizeTheme.current.commonWidgetsRadius)),
                  height: minSectionHeight * 1.2,
                  width: MediaQuery.of(context).size.width,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return CarouselSlider(
                      options: CarouselOptions(
                        viewportFraction: .90,
                        enableInfiniteScroll: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        pageSnapping: true,
                        disableCenter: true,
                      ),
                      items: [
                        ...announcements.map((AnnouncementModel announcement) =>
                            PromotionItemWidget(
                              announcement: announcement,
                              onTap: (announcement) => RoutingManager.router
                                  .pushNamed(
                                      RoutingManager.announcementDetailsScreen,
                                      extra: announcement.id),
                            )),
                        Container(
                            margin: EdgeInsets.only(
                                right:
                                    context.responsiveAppSizeTheme.current.p8),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: const AssetImage(DrawableAssetStrings
                                      .announcementSeeMoreBg),
                                  opacity: .45,
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(context
                                  .responsiveAppSizeTheme
                                  .current
                                  .commonWidgetsRadius),
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1),
                            ),
                            child: InkWell(
                              onTap: () {
                                RoutingManager.router.pushNamed(
                                  RoutingManager.allAnnouncementsScreen,
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    DrawableAssetStrings.glassIcon,
                                    width: context.responsiveAppSizeTheme
                                        .current.iconSize20,
                                    height: context.responsiveAppSizeTheme
                                        .current.iconSize20,
                                  ),
                                  const ResponsiveGap.s8(),
                                  Text(
                                    "${context.translation!.see_all} ",
                                    style: context.responsiveTextTheme.current
                                        .body3Regular
                                        .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right_outlined,
                                    color: Colors.black,
                                    size: context.responsiveAppSizeTheme.current
                                        .iconSize20,
                                  )
                                ],
                              ),
                            )),
                      ],
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
