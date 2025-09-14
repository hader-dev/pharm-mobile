import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/para_pharma_widget_2.dart';
import 'package:hader_pharm_mobile/features/common_features/anouncement_details/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/widget/search_filter_bottom_sheet.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/responsive/silver_grid_params.dart';
import 'package:iconsax/iconsax.dart';

class ParapharmaPage extends StatefulWidget {
  const ParapharmaPage({super.key});

  @override
  State<ParapharmaPage> createState() => _ParapharmaPageState();
}

class _ParapharmaPageState extends State<ParapharmaPage>
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
                    context: context, child: SearchMedicineFilterBottomSheet());
              },
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<ParaPharmaCubit, ParaPharmaState>(
            builder: (bContext, state) {
              if (state is MedicineLiked || state is MedicineLikeFailed) {}
              if (state is MedicineProductsLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final paraPharmaProducts =
                  BlocProvider.of<ParaPharmaCubit>(bContext).paraPharmaProducts;

              if (paraPharmaProducts.isEmpty) {
                return EmptyListWidget();
              }

              final bool isLoadingMore = state is LoadingMoreParaPharma;
              final bool hasReachedEnd = state is ParaPharmasLoadLimitReached;

              void onLikeTapped(BaseParaPharmaCatalogModel paraPharma) {
                final id = paraPharma.id;
                paraPharma.isLiked
                    ? BlocProvider.of<ParaPharmaCubit>(bContext)
                        .unlikeParaPharmaCatalog(id)
                    : BlocProvider.of<ParaPharmaCubit>(bContext)
                        .likeParaPharmaCatalog(id);
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () {
                        return BlocProvider.of<ParaPharmaCubit>(bContext)
                            .getParaPharmas();
                      },
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: calculateMarketplaceCrossAxisCount(
                              bContext.deviceSize),
                          crossAxisSpacing: calculateMarketplaceGridSpacing(
                              bContext.deviceSize),
                          mainAxisSpacing: calculateMarketplaceMainAxisSpacing(
                              bContext.deviceSize),
                          childAspectRatio:
                              calculateAllAnnouncementsAspectRatio(
                                  bContext.deviceSize, bContext.orientation),
                        ),
                        controller: BlocProvider.of<ParaPharmaCubit>(bContext)
                            .scrollController,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: paraPharmaProducts.length +
                            (isLoadingMore || hasReachedEnd ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < paraPharmaProducts.length) {
                            final paraPharma = paraPharmaProducts[index];
                            return ParaPharmaWidget2(
                              paraPharmData: paraPharma,
                              onFavoriteCallback: onLikeTapped,
                            );
                          } else {
                            if (isLoadingMore) {
                              return const Padding(
                                padding: EdgeInsets.all(AppSizesManager.s16),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            } else if (hasReachedEnd) {
                              return const EndOfLoadResultWidget();
                            }
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                  if (state is LoadingMoreMedicine)
                    const Center(child: CircularProgressIndicator()),
                  if (state is ParaPharmasLoadLimitReached)
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
