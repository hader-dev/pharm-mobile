import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'package:iconsax/iconsax.dart';

import '../../../../../config/theme/colors_manager.dart';

import '../../../../../utils/bottom_sheet_helper.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/enums.dart';
import '../../../../common/text_fields/custom_text_field.dart';
import '../../../../common/widgets/empty_list.dart';
import '../../../../common/widgets/end_of_load_result_widget.dart';
import 'cubit/vendors_cubit.dart';
import 'widgets/search_filter_bottom_sheet.dart';
import '../../../../common/widgets/vendor_item.dart';

class VendorsPage extends StatefulWidget {
  const VendorsPage({super.key});

  @override
  State<VendorsPage> createState() => _VendorsPageState();
}

class _VendorsPageState extends State<VendorsPage>
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
                  hintText: context.translation!.search_by_name_packaging_sku,
                  controller:
                      BlocProvider.of<VendorsCubit>(context).searchController,
                  state: FieldState.normal,
                  isEnabled: true,
                  prefixIcon: Icon(
                    Iconsax.search_normal,
                    color: AppColors.accent1Shade1,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      BlocProvider.of<VendorsCubit>(context)
                          .searchController
                          .clear();
                      BlocProvider.of<VendorsCubit>(context).searchVendor(null);
                    },
                    child: Icon(
                      Icons.clear,
                      color: AppColors.accent1Shade1,
                    ),
                  ),
                  onChanged: (searchValue) {
                    BlocProvider.of<VendorsCubit>(context)
                        .searchVendor(searchValue);
                  },
                  validationFunc: (value) {},
                ),
              ),
            ),
            InkWell(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSizesManager.p12),
                child: BlocBuilder<VendorsCubit, VendorsState>(
                  builder: (context, state) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          Iconsax.filter,
                          color: AppColors.accent1Shade1,
                        ),
                        if (BlocProvider.of<VendorsCubit>(context)
                                .selectedVendorSearchFilter !=
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
                    context: context, child: VandorsSearchFilterBottomSheet());
              },
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<VendorsCubit, VendorsState>(
            builder: (context, state) {
              final cubit = BlocProvider.of<VendorsCubit>(context);
              final vendors = cubit.vendorsList;

              if (state is VendorsLoading && vendors.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is VendorsLoaded && vendors.isEmpty) {
                return EmptyListWidget();
              }

              final bool isLoadingMore = state is VendorsLoadingMore;
              final bool hasReachedEnd = state is VendorsLoadLimitReached;

              return RefreshIndicator(
                onRefresh: () => cubit.fetchVendors(),
                child: ListView.builder(
                  controller: cubit.scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount:
                      vendors.length + (isLoadingMore || hasReachedEnd ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < vendors.length) {
                      return VendorItem(companyData: vendors[index]);
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
        ),
      ],
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
