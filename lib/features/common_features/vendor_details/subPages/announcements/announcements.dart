import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/promotion_item_widget.dart';
import 'package:hader_pharm_mobile/features/common_features/announcements/cubit/all_announcements_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/anouncement_details/cubit/announcement_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/responsive/silver_grid_params.dart';

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({super.key});

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
        child: Column(
      children: [
        Expanded(
          child: BlocBuilder<AllAnnouncementsCubit, AllAnnouncementsState>(
            builder: (bContext, state) {
              if (state is AnnouncementIsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (BlocProvider.of<AllAnnouncementsCubit>(bContext)
                      .announcements
                      .isEmpty ||
                  state is AllAnnouncementsLoadingFailed) {
                return EmptyListWidget();
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: RefreshIndicator(
                        onRefresh: () {
                          return BlocProvider.of<AllAnnouncementsCubit>(
                                  bContext)
                              .getAnnouncements();
                        },
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: calculateMarketplaceCrossAxisCount(
                                context.deviceSize),
                            crossAxisSpacing: calculateMarketplaceGridSpacing(
                                context.deviceSize),
                            mainAxisSpacing:
                                calculateMarketplaceMainAxisSpacing(
                                    context.deviceSize),
                            childAspectRatio:
                                calculateAllAnnouncementsAspectRatio(
                                    context.deviceSize, context.orientation),
                          ),
                          controller:
                              BlocProvider.of<AllAnnouncementsCubit>(bContext)
                                  .scrollController,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount:
                              BlocProvider.of<AllAnnouncementsCubit>(bContext)
                                  .announcements
                                  .length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(AppSizesManager.p8),
                            child: PromotionItemWidget(
                              announcement:
                                  BlocProvider.of<AllAnnouncementsCubit>(
                                          context)
                                      .announcements[index],
                              filterColor: AppColors.accent1Shade2,
                              onForegroundColor: Colors.white,
                              onTap: (announcement) => RoutingManager.router
                                  .pushNamed(
                                      RoutingManager.announcementDetailsScreen,
                                      extra: announcement.id),
                            ),
                          ),
                        )),
                  ),
                  if (state is AllAnnouncementsLoading)
                    const Center(child: CircularProgressIndicator()),
                  if (state is AnnouncementsLoadLimitReached)
                    EndOfLoadResultWidget(),
                ],
              );
            },
          ),
        ),
      ],
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
