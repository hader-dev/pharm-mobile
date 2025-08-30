import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show
        BlocBuilder,
        BlocProvider,
        MultiBlocProvider,
        ReadContext,
        BlocListener;
import 'package:gap/gap.dart' show Gap;
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common_features/announcements/cubit/all_announcements_cubit.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/announcement_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/company_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';
import 'package:iconsax/iconsax.dart';

import 'cubit/vendor_details_cubit.dart';
import 'widget/tabs_section.dart';

class VendorDetails extends StatelessWidget {
  final String companyId;
  static final vendorDetailsScaffoldKey = GlobalKey<ScaffoldState>();
  const VendorDetails({super.key, required this.companyId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => VendorDetailsCubit(
                companyRepo: CompanyRepository(
              client: getItInstance.get<INetworkService>(),
              userManager: getItInstance.get<UserManager>(),
            ))
              ..getVendorDetails(companyId),
          ),
          BlocProvider(
              create: (context) => AllAnnouncementsCubit(
                    companyId: companyId,
                    announcementsRepo: PromotionRepository(
                      client: getItInstance.get<INetworkService>(),
                    ),
                    scrollController: ScrollController(),
                  )..getAnnouncements()),
        ],
        child: BlocListener<VendorDetailsCubit, VendorDetailsState>(
          listener: (context, state) {
            if (state is VendorLiked) {
              getItInstance.get<ToastManager>().showToast(
                  type: ToastType.success,
                  message: context.translation!.vendor_added_to_favorites);
            }
          },
          child: Scaffold(
            key: vendorDetailsScaffoldKey,
            appBar: CustomAppBarV2.alternate(
              leading: IconButton(
                icon: Icon(
                  Directionality.of(context) == TextDirection.rtl
                      ? Iconsax.arrow_right_3
                      : Iconsax.arrow_left_2,
                  color: AppColors.bgWhite,
                  size: AppSizesManager.iconSize25,
                ),
                onPressed: () {
                  context.pop();
                },
              ),
              title: BlocBuilder<VendorDetailsCubit, VendorDetailsState>(
                builder: (context, state) {
                  if (state is VendorDetailsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Row(children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AppColors.bgDisabled, width: 1.5),
                        image: DecorationImage(
                          image: context
                                      .read<VendorDetailsCubit>()
                                      .vendorData
                                      .image
                                      ?.path ==
                                  null
                              ? AssetImage(
                                  DrawableAssetStrings.companyPlaceHolderImg)
                              : NetworkImage(getItInstance
                                  .get<INetworkService>()
                                  .getFilesPath(context
                                          .read<VendorDetailsCubit>()
                                          .vendorData
                                          .image
                                          ?.path ??
                                      '')) as ImageProvider,
                        ),
                      ),
                    ),
                    Gap(AppSizesManager.s8),
                    Text(context.read<VendorDetailsCubit>().vendorData.name,
                        style: context
                            .responsiveTextTheme.current.headLine4SemiBold
                            .copyWith(color: AppColors.bgWhite))
                  ]);
                },
              ),
            ),
            body: BlocBuilder<VendorDetailsCubit, VendorDetailsState>(
              builder: (context, state) {
                if (state is VendorDetailsLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return VandorDetailsTabBarSection(
                  companyId: companyId,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
