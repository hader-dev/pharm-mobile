import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common/image/cached_network_image_with_asset_fallback.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/anouncement_details/cubit/announcement_cubit.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

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
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizesManager.r8),
                  child: CachedNetworkImageWithAssetFallback(
                    imageUrl: getItInstance
                        .get<INetworkService>()
                        .getFilesPath(state.announcement.image!.path),
                    assetImage: DrawableAssetStrings.companyPlaceHolderImg,
                    fit: BoxFit.fill,
                  ),
                ),
                const ResponsiveGap.s16(),
              ],
              Html(
                data: state.announcement.content,
                style: {
                  "body": Style(
                    fontSize: FontSize(
                      MediaQuery.of(context).textScaler.scale(
                          context.deviceSize.width <=
                                  DeviceSizes.largeMobile.width
                              ? 16
                              : 25),
                    ),
                    lineHeight: LineHeight(1.5),
                  ),
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
