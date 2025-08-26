import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/cubit/medicine_details_cubit.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class DistributorDetailsPage extends StatelessWidget {
  const DistributorDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = context.translation!;
    MedicineCatalogModel medicineCatalogData =
        BlocProvider.of<MedicineDetailsCubit>(context).state.medicineCatalogData!;

    final company = medicineCatalogData.company;
    final specialty =
        DistributorCategory.values.firstWhere((e) => e.id == company.type).name;

    return Markdown(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      data: """
# ${translations.description}

${company.description ?? translations.no_description_available}

## ${translations.specifications}

- **${translations.company_name}:** ${company.name}
- **${translations.specialty}:** $specialty
- **${translations.address}:** ${company.address ?? translations.no_address_available}
- **${translations.phone}:** ${company.phone ?? translations.no_phone_available}
- **${translations.email}:** ${company.email ?? translations.no_email_available}
""",
      styleSheet: MarkdownStyleSheet(
        h1: context.responsiveTextTheme.current.headLine3SemiBold
            .copyWith(color: AppColors.accent1Shade1),
        h2: context.responsiveTextTheme.current.headLine4SemiBold
            .copyWith(color: AppColors.accent1Shade1),
        p: context.responsiveTextTheme.current.body2Regular,
        listBullet: TextStyle(color: AppColors.accentGreenShade2),
        strong: TextStyle(
          color: AppColors.accentGreenShade2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
