import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/para_pharma_widget_1.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/para_medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/para_medical_filters.dart';
import 'package:hader_pharm_mobile/repositories/locale/filters/filters_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'package:iconsax/iconsax.dart';

import 'cubit/para_pharma_cubit.dart';

class ParaPharmaSearchFilterBottomSheet extends StatefulWidget {
  const ParaPharmaSearchFilterBottomSheet({super.key});

  @override
  State<ParaPharmaSearchFilterBottomSheet> createState() => _ParaPharmaSearchFilterBottomSheetState();
}

class _ParaPharmaSearchFilterBottomSheetState extends State<ParaPharmaSearchFilterBottomSheet>
    with AutomaticKeepAliveClientMixin {
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
                  controller: BlocProvider.of<ParaPharmaCubit>(context)
                      .searchController,
                  state: FieldState.normal,
                  isEnabled: true,
                  prefixIcon: Icon(
                    Iconsax.search_normal,
                    color: AppColors.accent1Shade1,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      BlocProvider.of<ParaPharmaCubit>(context)
                          .searchController
                          .clear();
                      BlocProvider.of<ParaPharmaCubit>(context)
                          .searchParaPharmaCatalog(null);
                    },
                    child: Icon(
                      Icons.clear,
                      color: AppColors.accent1Shade1,
                    ),
                  ),
                  onChanged: (searchValue) {
                    BlocProvider.of<ParaPharmaCubit>(context)
                        .searchParaPharmaCatalog(searchValue);
                  },
                  validationFunc: (value) {},
                ),
              ),
            ),
            InkWell(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSizesManager.p12),
                child: BlocBuilder<ParaPharmaCubit, ParaPharmaState>(
                  builder: (context, state) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          Iconsax.filter,
                          color: AppColors.accent1Shade1,
                        ),
                        if (BlocProvider.of<ParaPharmaCubit>(context)
                                .selectedParaPharmaSearchFilter !=
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
                  context: context,
                  child: BlocProvider(
                    create: (_) => ParaMedicalFiltersCubit(
                      filtersRepository: FiltersRepositoryImpl(),
                    )..loadParaMedicalFilters(),
                    child: ParaMedicalFiltersView(),
                  ),
                );
              },
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<ParaPharmaCubit, ParaPharmaState>(
            builder: (context, state) {
              final cubit = BlocProvider.of<ParaPharmaCubit>(context);
              final products = cubit.paraPharmaProducts;

              if (state is ParaPharmaProductsLoading && products.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ParaPharmaProductsLoaded && products.isEmpty) {
                return EmptyListWidget();
              }

              final bool isLoadingMore = state is LoadingMoreParaPharma;
              final bool hasReachedEnd = state is ParaPharmasLoadLimitReached;

              return RefreshIndicator(
                onRefresh: () => cubit.getParaPharmas(),
                child: ListView.builder(
                  controller: cubit.scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: products.length +
                      (isLoadingMore || hasReachedEnd ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < products.length) {
                      final paraPharma = products[index];
                      return ParaPharmaWidget1(
                        hideLikeButton: false,
                        paraPharmData: paraPharma,
                        isLiked: paraPharma.isLiked,
                        onLike: paraPharma.isLiked
                            ? () => cubit.unlikeParaPharmaCatalog(paraPharma.id)
                            : () => cubit.likeParaPharmaCatalog(paraPharma.id),
                      );
                    } else {
                      // Extra slot for loader or end message
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
