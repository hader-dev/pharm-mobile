import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/cubit/medicine_details_cubit.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class MedicineOverViewPage extends StatelessWidget {
  const MedicineOverViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = context.translation!;

    MedicineCatalogModel medicineCatalogData =
        BlocProvider.of<MedicineDetailsCubit>(context)
            .state
            .medicineCatalogData!;

    return Markdown(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      data: """
# ${translations.main_features}

- **${translations.pharmaceutical_form}:** ${medicineCatalogData.medicine.form}
- **${translations.dosage}:** ${medicineCatalogData.medicine.dosage}
- **${translations.packaging}:** ${medicineCatalogData.medicine.packaging}
- **${translations.type}:** ${medicineCatalogData.medicine.type}
- **${translations.status}:** ${medicineCatalogData.medicine.status}
- **${translations.lifetime}:** ${medicineCatalogData.medicine.lifeTime}
- **${translations.laboratory}:** ${medicineCatalogData.medicine.laboratoryHolder}
- **${translations.country_of_origin}:** ${medicineCatalogData.medicine.laboratoryCountry}
""",
      styleSheet: MarkdownStyleSheet(
        h1: context.responsiveTextTheme.current.headLine3SemiBold.copyWith(
          color: AppColors.accent1Shade1,
        ),
        p: context.responsiveTextTheme.current.bodySmall,
        listBullet: TextStyle(
          color: AppColors.accent1Shade1,
        ),
        strong: TextStyle(
          color: AppColors.accent1Shade1,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
