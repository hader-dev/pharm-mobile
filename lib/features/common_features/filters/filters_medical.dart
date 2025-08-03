


import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/filters_clinical.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/filters_commercial.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/filters_logistics.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/filters_others.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/filters_regulatory.dart';

class FiltersMedical extends StatelessWidget {
  const FiltersMedical({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FiltersAccordionClinical(),
        FiltersAccordionRegulatory(),
        FiltersAccordionCommercial(),
        FiltersAccordionLogistics(),
        FiltersAccordionOthers()
      ],
    );
  }
}