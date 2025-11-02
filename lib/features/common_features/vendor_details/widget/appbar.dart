import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/vendor_details/cubit/vendor_details_cubit.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';
import 'package:iconsax/iconsax.dart';

class VendorDetailsAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const VendorDetailsAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBarV2.alternate(
      leading: IconButton(
        icon: Icon(
          Directionality.of(context) == TextDirection.rtl
              ? Iconsax.arrow_right_3
              : Iconsax.arrow_left_2,
          color: AppColors.bgWhite,
          size: context.responsiveAppSizeTheme.current.iconSize25,
        ),
        onPressed: () {
          context.pop();
        },
      ),
      title: BlocBuilder<VendorDetailsCubit, VendorDetailsState>(
        builder: (context, state) {
          if (state is VendorLiked) {
            getItInstance.get<ToastManager>().showToast(
                type: ToastType.success,
                message: context.translation!.vendor_added_to_favorites);
          }

          if (state is VendorDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Row(children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.bgDisabled, width: 1.5),
                image: DecorationImage(
                  image: state.vendor.image?.path == null
                      ? AssetImage(DrawableAssetStrings.companyPlaceHolderImg)
                      : NetworkImage(getItInstance
                              .get<INetworkService>()
                              .getFilesPath(state.vendor.image?.path ?? ''))
                          as ImageProvider,
                ),
              ),
            ),
            const ResponsiveGap.s8(),
            Text(state.vendor.name,
                style: context.responsiveTextTheme.current.headLine4SemiBold
                    .copyWith(
                        color: AppColors.bgWhite,
                        overflow: TextOverflow.ellipsis))
          ]);
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
