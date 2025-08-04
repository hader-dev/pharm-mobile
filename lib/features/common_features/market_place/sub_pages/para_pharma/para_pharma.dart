import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/para_pharma_widget_1.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'package:iconsax/iconsax.dart';

import 'cubit/para_pharma_cubit.dart';
import 'widget/search_filter_bottom_sheet.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: AppSizesManager.p8),
                child: CustomTextField(
                  hintText: context.translation!.search_by_name_packaging_sku,
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
                          return BlocProvider.of<ParaPharmaCubit>(context).getParaPharmas();
                        },
                        child: ListView.builder(
                          controller: BlocProvider.of<ParaPharmaCubit>(context).scrollController,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: BlocProvider.of<ParaPharmaCubit>(context).paraPharmaProducts.length,
                          itemBuilder: (context, index) => ParaPharmaWidget1(
                            hideLikeButton: false,
                            paraPharmData: BlocProvider.of<ParaPharmaCubit>(context).paraPharmaProducts[index],
                            isLiked: BlocProvider.of<ParaPharmaCubit>(context).paraPharmaProducts[index].isLiked,
                            onLike: !BlocProvider.of<ParaPharmaCubit>(context).paraPharmaProducts[index].isLiked
                                ? () => BlocProvider.of<ParaPharmaCubit>(context).likeParaPharmaCatalog(
                                    BlocProvider.of<ParaPharmaCubit>(context).paraPharmaProducts[index].id)
                                : () => BlocProvider.of<ParaPharmaCubit>(context).unlikeParaPharmaCatalog(
                                    BlocProvider.of<ParaPharmaCubit>(context).paraPharmaProducts[index].id),
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
