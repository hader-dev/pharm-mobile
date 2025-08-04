import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';

import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/medicine_widget_2.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import 'cubit/medicine_products_cubit.dart';
import 'widget/search_filter_bottom_sheet.dart' show SearchFilterBottomSheet;

class MedicineProductsPage extends StatefulWidget {
  const MedicineProductsPage({super.key});

  @override
  State<MedicineProductsPage> createState() => _MedicineProductsPageState();
}

class _MedicineProductsPageState extends State<MedicineProductsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
        child: Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: AppSizesManager.p8),
                child: CustomTextField(
                  hintText: context.translation!.medicines_search_field_hint,
                  controller: BlocProvider.of<MedicineProductsCubit>(context)
                      .searchController,
                  state: FieldState.normal,
                  isEnabled: true,
                  prefixIcon: Icon(
                    Iconsax.search_normal,
                    color: AppColors.accent1Shade1,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      BlocProvider.of<MedicineProductsCubit>(context)
                          .searchController
                          .clear();
                      BlocProvider.of<MedicineProductsCubit>(context)
                          .searchMedicineCatalog(null);
                    },
                    child: Icon(
                      Icons.clear,
                      color: AppColors.accent1Shade1,
                    ),
                  ),
                  onChanged: (searchValue) {
                    BlocProvider.of<MedicineProductsCubit>(context)
                        .searchMedicineCatalog(searchValue);
                  },
                  validationFunc: (value) {},
                ),
              ),
            ),
            InkWell(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSizesManager.p12),
                child:
                    BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
                  builder: (context, state) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          Iconsax.filter,
                          color: AppColors.accent1Shade1,
                        ),
                        if (BlocProvider.of<MedicineProductsCubit>(context)
                                .selectedMedicineSearchFilter !=
                            null)
                          Positioned(
                            top: -4,
                            right: -4,
                            child: CircleAvatar(
                              radius: AppSizesManager.commonWidgetsRadius,
                              backgroundColor: Colors.red,
                            ),
                          )
                      ],
                    );
                  },
                ),
              ),
              onTap: () {
                BottomSheetHelper.showCommonBottomSheet(
                    context: context, child: SearchFilterBottomSheet());
              },
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
            builder: (context, state) {
              final cubit = BlocProvider.of<MedicineProductsCubit>(context);
              final medicines = cubit.medicines;

              if (state is MedicineProductsLoading && medicines.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is MedicineProductsLoaded && medicines.isEmpty) {
                return EmptyListWidget();
              }

              final bool isLoadingMore = state is MedicineProductsLoading;
              final bool hasReachedEnd = state is MedicinesLoadLimitReached;

              return RefreshIndicator(
                onRefresh: () => cubit.getMedicines(),
                child: ListView.builder(
                  controller: cubit.scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: medicines.length +
                      (isLoadingMore || hasReachedEnd ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < medicines.length) {
                      final medicine = medicines[index];
                      return MedicineWidget2(
                        hideLikeButton: false,
                        medicineData: medicine,
                        isLiked: medicine.isLiked,
                        onLikeTapped: () {
                          final id = medicine.id;
                          medicine.isLiked
                              ? cubit.unlikeMedicinesCatalog(id)
                              : cubit.likeMedicinesCatalog(id);
                        },
                      );
                    } else {
                      if (isLoadingMore) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (hasReachedEnd) {
                        return const EndOfLoadResultWidget();
                      }
                    }
                    return const SizedBox.shrink();
                  },
                ),
              );
            },
          ),
        )
      ],
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
