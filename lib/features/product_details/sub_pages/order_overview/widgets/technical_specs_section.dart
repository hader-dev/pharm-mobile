import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

import '../../../../../config/theme/typoghrapy_manager.dart';

class SpecificationsWidget extends StatelessWidget {
  final Map<String, String> specifications = const {
    "Connectivité": "Wi-Fi 2.4 GHz",
    "Compatibilité": "iOS, Android, Alexa, Google",
    "Alimentation": "220V ou 3x piles AA",
    "Dimensions": "86 x 86 x 25 mm",
  };

  const SpecificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(AppSizesManager.p16),
          child: Row(
            children: [
              Icon(Icons.settings, color: AppColors.accentGreenShade2),
              Gap(AppSizesManager.s8),
              Text(
                'Spécifications techniques',
                style: AppTypography.headLine3SemiBoldStyle,
              ),
            ],
          ),
        ),
        ExpansionTile(
          title: const Text('Caractéristique', style: AppTypography.body3RegularStyle),
          dense: true,
          initiallyExpanded: true,
          maintainState: true,
          trailing: Text(
            'Détail',
            style: AppTypography.body3MediumStyle,
          ),
          children: [
            ...specifications.entries.map((entry) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p16, vertical: AppSizesManager.p16),
                decoration:
                    BoxDecoration(border: Border(bottom: BorderSide(color: StrokeColors.normal.color, width: 1))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(entry.key, style: AppTypography.body3RegularStyle),
                    Expanded(
                      child: Text(entry.value, textAlign: TextAlign.end, style: AppTypography.body3RegularStyle),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ],
    );
  }
}
