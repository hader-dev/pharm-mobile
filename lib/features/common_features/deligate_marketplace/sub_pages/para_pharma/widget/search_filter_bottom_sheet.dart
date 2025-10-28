import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/parapharm/provider.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/pages/para_medical_filters.dart';

class SearchParaPharmFilterBottomSheet extends StatelessWidget {
  const SearchParaPharmFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ParaPharmFilterProvider(
      child: ParaMedicalFiltersView(),
    );
  }
}
