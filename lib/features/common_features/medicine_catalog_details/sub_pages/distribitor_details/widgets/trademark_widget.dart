import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/cubit/medicine_details_cubit.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class TrademarkWidget extends StatelessWidget {
  const TrademarkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MedicineCatalogModel medicineCatalogData =
        BlocProvider.of<MedicineDetailsCubit>(context)
            .state
            .medicineCatalogData!;

    return ColoredBox(
      color: AppColors.accent1Shade2.withAlpha(200),
      child: Padding(
        padding: const EdgeInsets.all(AppSizesManager.p4),
        child: Row(
          children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.bgDisabled, width: 1.5),
                image: DecorationImage(
                  image: medicineCatalogData.company.thumbnailImage?.path ==
                          null
                      ? AssetImage(DrawableAssetStrings.companyPlaceHolderImg)
                      : NetworkImage(
                          getItInstance.get<INetworkService>().getFilesPath(
                                medicineCatalogData
                                    .company.thumbnailImage!.path,
                              ),
                        ),
                ),
              ),
            ),
            const ResponsiveGap.s4(),
            Text(medicineCatalogData.company.name,
                style: context.responsiveTextTheme.current.body3Regular
                    .copyWith(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
