import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../utils/enums.dart';
import 'order_summary_section.dart';

class OrderInvoiceSection extends StatelessWidget {
  final InvoiceTypes invoiceType;
  const OrderInvoiceSection({super.key, required this.invoiceType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: context.responsiveAppSizeTheme.current.p12,
          horizontal: context.responsiveAppSizeTheme.current.p8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.translation!.order_invoice,
            style: context.responsiveTextTheme.current.headLine4SemiBold,
          ),
          const ResponsiveGap.s4(),
          SummaryRow(
            label: context.translation!.invoice_type,
            value: invoiceType.name,
          ),
        ],
      ),
    );
  }
}
