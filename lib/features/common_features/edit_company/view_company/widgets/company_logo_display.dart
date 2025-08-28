import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/features/common_features/edit_company/cubit/edit_company_cubit.dart';

class CompanyLogoDisplay extends StatelessWidget {
  const CompanyLogoDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCompanyCubit, EditCompanyState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<EditCompanyCubit>(context);
        final companyImage = cubit.companyData?.image;
        final imageUrl = companyImage != null
            ? getItInstance.get<INetworkService>().getFilesPath(companyImage.path)
            : null;

       
        final imageSize = MediaQuery.of(context).size.width > 600 
            ? MediaQuery.of(context).size.height * 0.18
            : MediaQuery.of(context).size.height * 0.14;

        return Column(
          children: [
            Text(
              'Company Logo',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: TextColors.ternary.color,
              ),
            ),
            const SizedBox(height: AppSizesManager.s16),
            Container(
              height: imageSize,
              width: imageSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.bgDarken,
                border: Border.all(
                  color: AppColors.bgDarken2,
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppColors.bgDarken,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.bgDarken,
                          child: const Icon(
                            Iconsax.building,
                            size: AppSizesManager.iconSize48,
                            color: AppColors.accent1Shade1,
                          ),
                        ),
                      )
                    : Container(
                        color: AppColors.bgDarken,
                        child: const Icon(
                          Iconsax.building,
                          size: AppSizesManager.iconSize48,
                          color: AppColors.accent1Shade1,
                        ),
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
