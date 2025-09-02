import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/image/cached_network_image_with_asset_fallback.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/info_widget.dart';
import 'package:hader_pharm_mobile/features/common_features/order_complaint_details/cubit/orders_complaint_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/order_complaint_details/views/complaint_status_history.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class ComplaintReviewView extends StatelessWidget {
  const ComplaintReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final cubit = context.read<OrderComplaintsCubit>();
    final item = cubit.orderItemData!;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizesManager.p8),
              color: item.imageUrl == null ? Colors.grey.shade100 : null,
            ),
            child: CachedNetworkImageWithAssetFallback(
              imageUrl: getItInstance
                  .get<INetworkService>()
                  .getFilesPath(item.imageUrl ?? ""),
              fit: BoxFit.cover,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.15,
              assetImage: DrawableAssetStrings.medicinePlaceHolderImg,
            ),
          ),
          const ResponsiveGap.s12(),
          InfoWidget(
            label: translation.item_complaint,
            value: Text(
              "#${cubit.claimData!.id}",
              style: context.responsiveTextTheme.current.body2Medium,
            ),
          ),
          InfoWidget(
            label: translation.subject,
            value: Text(
              cubit.claimData!.subject,
              style: context.responsiveTextTheme.current.body2Medium,
            ),
          ),
          InfoWidget(
            label: translation.product,
            value: Text(
              item.designation ?? translation.unknown,
              style: context.responsiveTextTheme.current.body2Medium,
            ),
          ),
          InfoWidget(
            label: translation.quantity,
            value: Text(
              item.quantity.toString(),
              style: context.responsiveTextTheme.current.body2Medium,
            ),
          ),
          InfoWidget(
            label: translation.description,
            value: Text(
              cubit.claimData!.description,
              style: context.responsiveTextTheme.current.body2Medium,
            ),
          ),
          Divider(color: AppColors.accent1Shade1, thickness: 1, height: 1),
          ComplaintStatusHistory(),
        ],
      ),
    );
  }
}
