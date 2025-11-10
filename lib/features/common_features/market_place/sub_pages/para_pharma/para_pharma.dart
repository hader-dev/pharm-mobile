import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/para_pharma_widget_1.dart';
import 'package:hader_pharm_mobile/features/common_features/home/home.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/widget/filters_bar.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'cubit/para_pharma_cubit.dart';

class ParaPharmaProductsPage extends StatefulWidget {
  const ParaPharmaProductsPage({super.key});

  @override
  State<ParaPharmaProductsPage> createState() => _ParaPharmaProductsPageState();
}

class _ParaPharmaProductsPageState extends State<ParaPharmaProductsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ParaPharmaCubit>(context);

    super.build(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FiltersBar(),
            Expanded(
              child: BlocBuilder<ParaPharmaCubit, ParaPharmaState>(
                builder: (context, state) {
                  final products = state.paraPharmaProducts;
                  final gCubit = MarketPlaceScreen
                      .marketPlaceScaffoldKey.currentContext!
                      .read<ParaPharmaCubit>();
                  final hCubit = HomeScreen.scaffoldKey.currentContext
                      ?.read<ParaPharmaCubit>();

                  final bool isLoadingMore = state is LoadingMoreParaPharma;
                  final bool hasReachedEnd =
                      state is ParaPharmasLoadLimitReached;

                  void onLikeTapped(BaseParaPharmaCatalogModel medicine) {
                    final id = medicine.id;
                    medicine.isLiked
                        ? cubit.unlikeParaPharmaCatalog(id)
                        : cubit.likeParaPharmaCatalog(id);
                    gCubit.refreshParaPharmaCatalogFavorite(
                        id, !medicine.isLiked);
                    hCubit?.refreshParaPharmaCatalogFavorite(
                        id, !medicine.isLiked);
                  }

                  return RefreshIndicator(
                    onRefresh: () => cubit.getParaPharmas(),
                    child: (state is ParaPharmaProductsLoadingFailed ||
                            products.isEmpty)
                        ? LayoutBuilder(
                            builder: (context, constraints) {
                              return SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: SizedBox(
                                  height: constraints.maxHeight,
                                  child: const Center(child: EmptyListWidget()),
                                ),
                              );
                            },
                          )
                        : ListView.builder(
                            controller: cubit.scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: products.length +
                                (isLoadingMore || hasReachedEnd ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index < products.length) {
                                final paraPharma = products[index];
                                return ParaPharmaWidget1(
                                  paraPharmData: paraPharma,
                                  onFavoriteCallback: onLikeTapped,
                                  isLiked: paraPharma.isLiked,
                                );
                              } else {
                                if (isLoadingMore) {
                                  return const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Center(
                                        child: CircularProgressIndicator()),
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
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
