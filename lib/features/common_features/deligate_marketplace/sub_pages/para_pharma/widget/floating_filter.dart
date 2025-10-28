import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/buttons/filter_button.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_marketplace/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_marketplace/sub_pages/para_pharma/widget/search_filter_bottom_sheet.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';

class FloatingFilterParaMedical extends StatelessWidget {
  const FloatingFilterParaMedical({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParaPharmaCubit, ParaPharmaState>(
      builder: (context, state) {
        return FloatingFilter.floating(
          onTap: () {
            BottomSheetHelper.showCommonBottomSheet(
              context: context,
              child: SearchParaPharmFilterBottomSheet(),
            );
          },
        );
      },
    );
  }
}
