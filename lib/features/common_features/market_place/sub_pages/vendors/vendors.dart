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
import 'cubit/vendors_cubit.dart';
import 'widgets/search_filter_bottom_sheet.dart';
import '../../../../common/widgets/vendor_item.dart';

class VendorsPage extends StatefulWidget {
  const VendorsPage({super.key});

  @override
  State<VendorsPage> createState() => _VendorsPageState();
}

class _VendorsPageState extends State<VendorsPage> with AutomaticKeepAliveClientMixin {
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
                  controller: BlocProvider.of<VendorsCubit>(context).searchController,
                  state: FieldState.normal,
                  isEnabled: true,
                  prefixIcon: Icon(
                    Iconsax.search_normal,
                    color: AppColors.accent1Shade1,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      BlocProvider.of<VendorsCubit>(context).searchController.clear();
                      BlocProvider.of<VendorsCubit>(context).searchVendor(null);
                    },
                    child: Icon(
                      Icons.clear,
                      color: AppColors.accent1Shade1,
                    ),
                  ),
                  onChanged: (searchValue) {
                    BlocProvider.of<VendorsCubit>(context).searchVendor(searchValue);
                  },
                  validationFunc: (value) {},
                ),
              ),
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p12),
                child: BlocBuilder<VendorsCubit, VendorsState>(
                  builder: (context, state) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          Iconsax.filter,
                          color: AppColors.accent1Shade1,
                        ),
                        if (BlocProvider.of<VendorsCubit>(context).selectedVendorSearchFilter != null)
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
                BottomSheetHelper.showCommonBottomSheet(context: context, child: VandorsSearchFilterBottomSheet());
              },
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<VendorsCubit, VendorsState>(
            builder: (context, state) {
              if (state is VendorsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is VendorsLoaded && BlocProvider.of<VendorsCubit>(context).vendorsList.isEmpty) {
                return EmptyListWidget();
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: RefreshIndicator(
                        onRefresh: () {
                          return BlocProvider.of<VendorsCubit>(context).fetchVendors();
                        },
                        child: ListView.builder(
                          controller: BlocProvider.of<VendorsCubit>(context).scrollController,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: BlocProvider.of<VendorsCubit>(context).vendorsList.length,
                          itemBuilder: (context, index) {
                            return VendorItem(
                              companyData: BlocProvider.of<VendorsCubit>(context).vendorsList[index],
                            );
                          },
                        )),
                  ),
                  if (state is VendorsLoadingMore) const Center(child: CircularProgressIndicator()),
                  if (state is VendorsLoadLimitReached) EndOfLoadResultWidget(),
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
