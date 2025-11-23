import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart' show getItInstance;
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart'
    show INetworkService;
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart'
    show ResponsiveGap;
import 'package:hader_pharm_mobile/features/common_features/vendor_details/cubit/vendor_details_cubit.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart'
    show DrawableAssetStrings;
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class VendorDetailsAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const VendorDetailsAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorDetailsCubit, VendorDetailsState>(
      builder: (context, state) {
        final vendorData = state.vendor;
        return CustomAppBarV2.normal(
          leading: IconButton(
            icon: Icon(
              Directionality.of(context) == TextDirection.rtl
                  ? Iconsax.arrow_right_3
                  : Iconsax.arrow_left_2,
              color: AppColors.accent1Shade1,
              size: context.responsiveAppSizeTheme.current.iconSize25,
            ),
            onPressed: () {
              context.pop();
            },
          ),
          title: Row(children: [
            Container(
              height: context.responsiveAppSizeTheme.current.iconSize48,
              width: context.responsiveAppSizeTheme.current.iconSize48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.bgDisabled, width: 1.5),
                image: DecorationImage(
                  image: vendorData.image?.path == null
                      ? AssetImage(DrawableAssetStrings.companyPlaceHolderImg)
                      : NetworkImage(getItInstance
                              .get<INetworkService>()
                              .getFilesPath(vendorData.image?.path ?? ''))
                          as ImageProvider,
                ),
              ),
            ),
            const ResponsiveGap.s8(),
            Text(vendorData.name,
                style: context.responsiveTextTheme.current.headLine4SemiBold
                    .copyWith(
                        color: AppColors.accent1Shade1,
                        overflow: TextOverflow.ellipsis))
          ]),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
