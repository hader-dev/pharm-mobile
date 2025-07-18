import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../config/theme/colors_manager.dart';

import '../../../../../utils/bottom_sheet_helper.dart';
import '../../../../../utils/enums.dart';

import '../../../../common/text_fields/custom_text_field.dart';
import '../../../../common/widgets/end_of_load_result_widget.dart';

import '../../../../common/widgets/medicine_widget_2.dart';
import 'cubit/medicine_products_cubit.dart';
import 'widget/search_filter_bottom_sheet.dart' show SearchFilterBottomSheet;

class MedicineProductsPage extends StatefulWidget {
  const MedicineProductsPage({super.key});

  @override
  State<MedicineProductsPage> createState() => _MedicineProductsPageState();
}

class _MedicineProductsPageState extends State<MedicineProductsPage> with AutomaticKeepAliveClientMixin {
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
                  hintText: context.translation!.medicinesSearchFieldHint,
                  controller: BlocProvider.of<MedicineProductsCubit>(context).searchController,
                  state: FieldState.normal,
                  isEnabled: true,
                  prefixIcon: Icon(
                    Iconsax.search_normal,
                    color: AppColors.accent1Shade1,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      BlocProvider.of<MedicineProductsCubit>(context).searchController.clear();
                      BlocProvider.of<MedicineProductsCubit>(context).searchMedicineCatalog(null);
                    },
                    child: Icon(
                      Icons.clear,
                      color: AppColors.accent1Shade1,
                    ),
                  ),
                  onChanged: (searchValue) {
                    BlocProvider.of<MedicineProductsCubit>(context).searchMedicineCatalog(searchValue);
                  },
                  validationFunc: (value) {},
                ),
              ),
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p12),
                child: BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
                  builder: (context, state) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          Iconsax.filter,
                          color: AppColors.accent1Shade1,
                        ),
                        if (BlocProvider.of<MedicineProductsCubit>(context).selectedMedicineSearchFilter != null)
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
                BottomSheetHelper.showCommonBottomSheet(context: context, child: SearchFilterBottomSheet());
              },
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
            builder: (context, state) {
              if (state is MedicineLiked || state is MedicineLikeFailed) {}
              if (state is MedicineProductsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is MedicineProductsLoaded &&
                  BlocProvider.of<MedicineProductsCubit>(context).medicines.isEmpty) {
                return EmptyListWidget();
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () {
                        return BlocProvider.of<MedicineProductsCubit>(context).getMedicines();
                      },
                      child: ListView.builder(
                        controller: BlocProvider.of<MedicineProductsCubit>(context).scrollController,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: BlocProvider.of<MedicineProductsCubit>(context).medicines.length,
                        itemBuilder: (context, index) => MedicineWidget2(
                          hideLikeButton: false,
                          medicineData: BlocProvider.of<MedicineProductsCubit>(context).medicines[index],
                          isLiked: BlocProvider.of<MedicineProductsCubit>(context).medicines[index].isLiked,
                          onLikeTapped: !BlocProvider.of<MedicineProductsCubit>(context).medicines[index].isLiked
                              ? () => BlocProvider.of<MedicineProductsCubit>(context).likeMedicinesCatalog(
                                  BlocProvider.of<MedicineProductsCubit>(context).medicines[index].id)
                              : () => BlocProvider.of<MedicineProductsCubit>(context).unlikeMedicinesCatalog(
                                  BlocProvider.of<MedicineProductsCubit>(context).medicines[index].id),
                        ),
                      ),
                    ),
                  ),
                  if (state is LoadingMoreMedicine) const Center(child: CircularProgressIndicator()),
                  if (state is MedicinesLoadLimitReached) EndOfLoadResultWidget(),
                ],
              );
            },
          ),
        ),
      ],
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
