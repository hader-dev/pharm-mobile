import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../../config/theme/colors_manager.dart';
import '../../../../../models/para_pharma.dart';
import '../../cubit/para_pharma_details_cubit.dart';

class ParaPharmaOverViewPage extends StatelessWidget {
  const ParaPharmaOverViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = context.translation!;
    ParaPharmaCatalogModel paraPharmaCatalogData =
        BlocProvider.of<ParaPharmaDetailsCubit>(context).paraPharmaCatalogData!;
    return Markdown(
      shrinkWrap: true,
      data: """
# ${translations.description}

${paraPharmaCatalogData.description}

## ${translations.specifications}

- **${translations.brand}:** ${paraPharmaCatalogData.brand.name}
- **${translations.category}:** ${paraPharmaCatalogData.category.name}
- **${translations.packaging}:** ${paraPharmaCatalogData.packaging}
""",
      styleSheet: MarkdownStyleSheet(
        h1: context.responsiveTextTheme.current.headLine3SemiBold
            .copyWith(color: AppColors.accent1Shade1),
        h2: context.responsiveTextTheme.current.headLine3SemiBold
            .copyWith(color: AppColors.accent1Shade1),
        p: context.responsiveTextTheme.current.body2Regular,
        listBullet: TextStyle(color: AppColors.accent1Shade1),
        strong: TextStyle(
          color: AppColors.accent1Shade1,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
