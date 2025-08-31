import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/medicine_widget_3.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';

class MedicinesSectionItems extends StatelessWidget {
  const MedicinesSectionItems({super.key, required this.minSectionHeight});
  final double minSectionHeight;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
      builder: (context, state) {
        MedicineProductsCubit medicinesCubit =
            context.read<MedicineProductsCubit>();
        final items = medicinesCubit.medicines;

        if (state is MedicineProductsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is MedicineProductsLoadingFailed || items.isEmpty) {
          return Center(
            child: EmptyListWidget(),
          );
        }
        void onFavoriteCallback(BaseMedicineCatalogModel medicine) {
                    medicine.isLiked
              ? medicinesCubit.unlikeMedicinesCatalog(medicine.id)
              : medicinesCubit.likeMedicinesCatalog(medicine.id);
        
        }

        return SizedBox(
          height: 240,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 0),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: screenWidth > 768 ? 300 : 240,
                child: MedicineWidget3(
                  medicineData: items[index],
                  onFavoriteCallback: onFavoriteCallback,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
