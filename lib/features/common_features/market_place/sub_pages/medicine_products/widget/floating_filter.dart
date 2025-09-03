import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/buttons/filter_button.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/widget/search_filter_bottom_sheet.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';

class FloatingFilterMedical extends StatelessWidget {
  const FloatingFilterMedical({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
      builder: (context, state) {
        return FloatingFilter.floating(
          onTap: () {
            BottomSheetHelper.showCommonBottomSheet(
              context: context,
              child: SearchMedicineFilterBottomSheet(),
            );
          },
        );
      },
    );
  }
}
