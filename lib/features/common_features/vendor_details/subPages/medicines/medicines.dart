import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/medicine_widget_3.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/widget/search_filter_bottom_sheet.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class MedicinesPage extends StatefulWidget {
  const MedicinesPage({super.key});

  @override
  State<MedicinesPage> createState() => _MedicinesPageState();
}

class _MedicinesPageState extends State<MedicinesPage>
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
                  hintText: context.translation!.search_by_dci_brand_sku,
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
                    context: context, child: SearchMedicineFilterBottomSheet());
              },
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
            builder: (bContext, state) {
              if (state is MedicineLiked || state is MedicineLikeFailed) {}
              if (state is MedicineProductsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (BlocProvider.of<MedicineProductsCubit>(bContext)
                  .medicines
                  .isEmpty) {
                return EmptyListWidget();
              }

              final crossAxisCount =
                  bContext.deviceSize.width <= DeviceSizes.mediumMobile.width
                      ? 1
                      : 2;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () {
                        return BlocProvider.of<MedicineProductsCubit>(bContext)
                            .getMedicines();
                      },
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: 0.7),
                        controller:
                            BlocProvider.of<MedicineProductsCubit>(bContext)
                                .scrollController,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount:
                            BlocProvider.of<MedicineProductsCubit>(bContext)
                                .medicines
                                .length,
                        itemBuilder: (context, index) => MedicineWidget3(
                          medicineData:
                              BlocProvider.of<MedicineProductsCubit>(context)
                                  .medicines[index],
                        ),
                      ),
                    ),
                  ),
                  if (state is LoadingMoreMedicine)
                    const Center(child: CircularProgressIndicator()),
                  if (state is MedicinesLoadLimitReached)
                    EndOfLoadResultWidget(),
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
