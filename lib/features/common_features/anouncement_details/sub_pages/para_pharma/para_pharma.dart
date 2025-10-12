import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/para_pharma_widget_1.dart';
import 'package:hader_pharm_mobile/features/common_features/anouncement_details/cubit/announcement_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/home/home.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';

class ParapharmaProductsPage extends StatefulWidget {
  const ParapharmaProductsPage({super.key});

  @override
  State<ParapharmaProductsPage> createState() => _ParapharmaProductsPageState();
}

class _ParapharmaProductsPageState extends State<ParapharmaProductsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final gCubit = MarketPlaceScreen.marketPlaceScaffoldKey.currentContext!
        .read<ParaPharmaCubit>();
    final hCubit =
        HomeScreen.scaffoldKey.currentContext?.read<ParaPharmaCubit>();

    return RefreshIndicator(
      onRefresh: () => context.read<AnnouncementCubit>().loadAnnouncement(),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder<AnnouncementCubit, AnnouncementState>(
                builder: (context, state) {
                  final cubit = context.read<AnnouncementCubit>();
                  final products = state.paraPharmas;

                  if (state is ParaPharmaProductsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (products.isEmpty) {
                    return const Center(child: EmptyListWidget());
                  }

                  final bool isLoadingMore = state is LoadingMoreParaPharma;
                  final bool hasReachedEnd =
                      state is ParaPharmasLoadLimitReached;

                  return RefreshIndicator(
                    onRefresh: () => cubit.loadAnnouncement(),
                    child: ListView.builder(
                      controller: state.scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: products.length +
                          (isLoadingMore || hasReachedEnd ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < products.length) {
                          final paraPharma = products[index];

                          void onLikeTapped(ParaPharmaCatalogModel medicine) {
                            final id = medicine.id;
                            medicine.isLiked
                                ? cubit.unlikeParaPharmaCatalog(medicine)
                                : cubit.likeParaPharmaCatalog(medicine);

                            gCubit.refreshParaPharmaCatalogFavorite(
                                id, !medicine.isLiked);
                            hCubit?.refreshParaPharmaCatalogFavorite(
                                id, !medicine.isLiked);
                          }

                          return ParaPharmaWidget1(
                              paraPharmData: paraPharma,
                              isLiked: paraPharma.isLiked,
                              onFavoriteCallback: (v) =>
                                  onLikeTapped(v as ParaPharmaCatalogModel));
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
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
