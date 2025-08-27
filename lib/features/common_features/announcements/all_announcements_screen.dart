import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/announcements/cubit/all_announcements_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/announcements/widgets/announcement_list_item.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/announcement_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class AllAnnouncementsScreen extends StatefulWidget {
  const AllAnnouncementsScreen({super.key});

  @override
  State<AllAnnouncementsScreen> createState() => _AllAnnouncementsScreenState();
}

class _AllAnnouncementsScreenState extends State<AllAnnouncementsScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
      )..getAnnouncements(),
      child: Scaffold(
        appBar:  CustomAppBarV2.alternate(
            topPadding: MediaQuery.of(context).padding.top,
            bottomPadding: MediaQuery.of(context).padding.bottom,
            leading: IconButton(
              icon: const Icon(
                Iconsax.arrow_left,
                color: Colors.white,
                size: AppSizesManager.iconSize25,
              ),
              onPressed: () => context.pop(),
            ),
            title: Text(
              context.translation!.all_announcements,
              style: context.responsiveTextTheme.current.headLine3SemiBold
                  .copyWith(
                color: Colors.white,
              ),
            ),
          ),
        body: BlocBuilder<AllAnnouncementsCubit, AllAnnouncementsState>(
          builder: (context, state) {
            if (state is AllAnnouncementsLoading && state.announcements.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AllAnnouncementsError && state.announcements.isEmpty) {
              return Center(
                child: EmptyListWidget(
                  onRefresh: () {
                    context.read<AllAnnouncementsCubit>().getAnnouncements();
                  },
                ),
              );
            }

            if (state.announcements.isEmpty) {
              return const Center(
                child: EmptyListWidget(),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<AllAnnouncementsCubit>().refreshAnnouncements();
              },
              child: ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.all(AppSizesManager.p16),
                itemCount: state.announcements.length + (state.hasReachedMax ? 0 : 1),
                separatorBuilder: (context, index) => const Gap(AppSizesManager.s12),
                itemBuilder: (context, index) {
                  if (index >= state.announcements.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppSizesManager.p16),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  final announcement = state.announcements[index];
                  return AnnouncementListItem(
                    announcement: announcement,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
