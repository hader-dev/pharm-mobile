import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:iconsax/iconsax.dart';

import '../../../../../config/theme/colors_manager.dart';

import '../../../../../utils/bottom_sheet_helper.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/enums.dart';
import '../../../../common/text_fields/custom_text_field.dart';
import '../../../../common/widgets/empty_list.dart';
import '../../../../common/widgets/end_of_load_result_widget.dart';

import '../../../../common/widgets/para_pharma_widget_2.dart';
import '../../../market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import '../../../market_place/sub_pages/para_pharma/widget/search_filter_bottom_sheet.dart';
import '../../cubit/vendor_details_cubit.dart';

class ParaPharmaPage extends StatefulWidget {
  const ParaPharmaPage({super.key});

  @override
  State<ParaPharmaPage> createState() => _ParaPharmaPageState();
}

class _ParaPharmaPageState extends State<ParaPharmaPage> with AutomaticKeepAliveClientMixin {
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
                  hintText: 'Search by name ,packaging or sku',
                  controller: BlocProvider.of<ParaPharmaCubit>(context).searchController,
                  state: FieldState.normal,
                  isEnabled: true,
                  prefixIcon: Icon(
                    Iconsax.search_normal,
                    color: AppColors.accent1Shade1,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      BlocProvider.of<ParaPharmaCubit>(context).searchController.clear();
                      BlocProvider.of<ParaPharmaCubit>(context).searchParaPharmaCatalog(null);
                    },
                    child: Icon(
                      Icons.clear,
                      color: AppColors.accent1Shade1,
                    ),
                  ),
                  onChanged: (searchValue) {
                    BlocProvider.of<ParaPharmaCubit>(context).searchParaPharmaCatalog(searchValue);
                  },
                  validationFunc: (value) {},
                ),
              ),
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p12),
                child: BlocBuilder<ParaPharmaCubit, ParaPharmaState>(
                  builder: (context, state) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          Iconsax.filter,
                          color: AppColors.accent1Shade1,
                        ),
                        if (BlocProvider.of<ParaPharmaCubit>(context).selectedParaPharmaSearchFilter != null)
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
                BottomSheetHelper.showCommonBottomSheet(context: context, child: ParaPharmaSearchFilterBottomSheet());
              },
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<ParaPharmaCubit, ParaPharmaState>(
            builder: (context, state) {
              if (state is ParaPharmaProductsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ParaPharmaProductsLoaded &&
                  BlocProvider.of<ParaPharmaCubit>(context).paraPharmaProducts.isEmpty) {
                return EmptyListWidget();
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: RefreshIndicator(
                        onRefresh: () {
                          return BlocProvider.of<ParaPharmaCubit>(context).getParaPharmas(
                            companyIdFilter: BlocProvider.of<VendorDetailsCubit>(context).vendorData.id,
                          );
                        },
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7),
                          controller: BlocProvider.of<ParaPharmaCubit>(context).scrollController,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: BlocProvider.of<ParaPharmaCubit>(context).paraPharmaProducts.length,
                          itemBuilder: (context, index) => ParaPharmaWidget2(
                            paraPharmData: BlocProvider.of<ParaPharmaCubit>(context).paraPharmaProducts[index],
                          ),
                        )),
                  ),
                  if (state is LoadingMoreParaPharma) const Center(child: CircularProgressIndicator()),
                  if (state is ParaPharmasLoadLimitReached) EndOfLoadResultWidget(),
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
