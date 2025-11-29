import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart' show RoutingManager;
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart' show AppColors;
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common/shimmers/announcement_grid_item_shimmer.dart'
    show AnnouncementGridItemWidgetShimmer;
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/announcements/cubit/all_announcements_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/announcements/widgets/announcements_search_widget.dart';
import 'package:hader_pharm_mobile/features/common_features/announcements/widgets/announcment_grid_item.dart'
    show PromotionItemWidget;
import 'package:hader_pharm_mobile/repositories/remote/announcement/announcement_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class AllAnnouncementsScreen extends StatefulWidget {
  const AllAnnouncementsScreen({super.key});

  @override
  State<AllAnnouncementsScreen> createState() => _AllAnnouncementsScreenState();
}

class _AllAnnouncementsScreenState extends State<AllAnnouncementsScreen> {
  late ScrollController _scrollController;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllAnnouncementsCubit(
        announcementsRepo: PromotionRepository(
          client: getItInstance.get<INetworkService>(),
        ),
        scrollController: _scrollController,
        searchController: _searchController,
      )..getAnnouncements(),
      child: Scaffold(
        appBar: CustomAppBarV2.normal(
          leading: IconButton(
            icon: Icon(
              Iconsax.arrow_left_2,
              color: AppColors.accent1Shade1,
              size: context.responsiveAppSizeTheme.current.iconSize25,
            ),
            onPressed: () => context.pop(),
          ),
          title: Text(
            context.translation!.all_announcements,
            style: context.responsiveTextTheme.current.headLine3SemiBold.copyWith(
              color: AppColors.accent1Shade1,
            ),
          ),
        ),
        body: Column(children: [
          const AnnouncementsSearchWidget(),
          Expanded(
            child: BlocBuilder<AllAnnouncementsCubit, AllAnnouncementsState>(
              builder: (context, state) {
                if (state is AllAnnouncementsLoading) {
                  return Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p8),
                      child: Expanded(
                        child: GridView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: context.responsiveAppSizeTheme.current.s16,
                            mainAxisSpacing: context.responsiveAppSizeTheme.current.s16,
                            childAspectRatio: .8,
                          ),
                          scrollDirection: Axis.vertical,
                          itemCount: 12,
                          itemBuilder: (_, __) => const AnnouncementGridItemWidgetShimmer(),
                        ),
                      ));
                }

                if (state.announcements.isEmpty || state is AllAnnouncementsLoadingFailed) {
                  return Center(
                    child: EmptyListWidget(
                      onRefresh: () {
                        context.read<AllAnnouncementsCubit>().getAnnouncements();
                      },
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<AllAnnouncementsCubit>().refreshAnnouncements();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p8),
                    child: GridView.builder(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: context.responsiveAppSizeTheme.current.s16,
                          mainAxisSpacing: context.responsiveAppSizeTheme.current.s16,
                          childAspectRatio: 1,
                        ),
                        scrollDirection: Axis.vertical,
                        itemCount: state.announcements.length + (state.hasReachedMax ? 0 : 1),
                        itemBuilder: (context, index) {
                          if (index >= state.announcements.length) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p16),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          final announcement = state.announcements[index];
                          return PromotionItemWidget(
                            announcement: announcement,
                            onTap: (announcement) => RoutingManager.router
                                .pushNamed(RoutingManager.announcementDetailsScreen, extra: announcement.id),
                          );
                        }),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
