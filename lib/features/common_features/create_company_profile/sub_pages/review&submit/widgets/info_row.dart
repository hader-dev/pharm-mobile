import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

import '../../../../../../config/theme/colors_manager.dart';
import '../../../../../../config/theme/typoghrapy_manager.dart';

class InfoRow extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String dataValue;

  const InfoRow({super.key, this.icon, required this.label, this.dataValue = ""});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizesManager.p12),
      child: Row(
        children: [
          if (icon != null) Icon(icon, color: Colors.grey[700], size: 20),
          const Gap(AppSizesManager.s8),
          Text(label, style: AppTypography.body3MediumStyle.copyWith(color: TextColors.ternary.color)),
          Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width * 2 / 6,
            child: Tooltip(
              message: dataValue.isEmpty ? "Not Provided" : dataValue,
              triggerMode: TooltipTriggerMode.tap,
              child: Text(dataValue.isEmpty ? "Not Provided" : dataValue,
                  textAlign: TextAlign.end,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.body3MediumStyle),
            ),
          ),
        ],
      ),
    );
  }
}
