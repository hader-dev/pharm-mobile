import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common/image/cached_network_image_with_asset_fallback.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/anouncement_details/cubit/announcement_cubit.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

class AnnouncementOverviewPage extends StatelessWidget {
  const AnnouncementOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<AnnouncementCubit>().loadAnnouncement(),
      child: BlocBuilder<AnnouncementCubit, AnnouncementState>(
          builder: (context, state) {
        if (state is AnnouncementIsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.announcement.id.isEmpty ||
            state.announcement.content.isEmpty) {
          return const Center(child: EmptyListWidget());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizesManager.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.announcement.image != null) ...[
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizesManager.r8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImageWithAssetFallback(
                    imageUrl: getItInstance
                        .get<INetworkService>()
                        .getFilesPath(state.announcement.image!.path),
                    assetImage: DrawableAssetStrings.companyPlaceHolderImg,
                    fit: BoxFit.cover,
                  ),
                ),
                const ResponsiveGap.s16(),
              ],
              MarkdownBody(
                data: state.announcement.content,
              ),
            ],
          ),
        );
      }),
    );
  }
}
