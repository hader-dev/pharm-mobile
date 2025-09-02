import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/cubit/para_pharma_details_cubit.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class TrademarkWidget extends StatelessWidget {
  const TrademarkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ParaPharmaCatalogModel catalogData =
        BlocProvider.of<ParaPharmaDetailsCubit>(context).paraPharmaCatalogData!;

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
                  image: catalogData.company?.thumbnailImage?.path == null
                      ? AssetImage(DrawableAssetStrings.companyPlaceHolderImg)
                      : NetworkImage(
                          getItInstance.get<INetworkService>().getFilesPath(
                                catalogData.company!.thumbnailImage!.path,
                              ),
                        ),
                ),
              ),
            ),
            const ResponsiveGap.s4(),
            Text(catalogData.company!.name,
                style: context.responsiveTextTheme.current.body3Regular
                    .copyWith(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
