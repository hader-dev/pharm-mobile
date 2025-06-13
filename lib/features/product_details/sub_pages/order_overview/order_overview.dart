import 'package:flutter/material.dart';

import 'widgets/faq_section.dart';
import 'widgets/technical_specs_section.dart';

class OrderOverviewPage extends StatelessWidget {
  const OrderOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FAQSection(),
        SpecificationsWidget(),
      ],
    );
  }
}
