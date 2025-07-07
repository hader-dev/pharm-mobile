import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

import '../../../../config/theme/typoghrapy_manager.dart';
import '../../../../utils/enums.dart';
import 'order_summary_section.dart';

class OrderInvoiceSection extends StatelessWidget {
  const OrderInvoiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizesManager.p12, horizontal: AppSizesManager.p8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'order Invoice',
            style: AppTypography.headLine4SemiBoldStyle,
          ),
          Gap(AppSizesManager.s4),
          SummaryRow(
            label: 'Invoice type',
            value: InvoiceTypes.facture.name,
          ),
        ],
      ),
    );
  }
}
