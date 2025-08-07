import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/para_pharma_widget_1.dart';
import 'package:hader_pharm_mobile/features/common_features/anouncement_details/cubit/announcement_cubit.dart';
import 'cubit/para_pharma_cubit.dart';

class ParapharmaProductsPage extends StatefulWidget {
  const ParapharmaProductsPage({super.key});

  @override
  State<ParapharmaProductsPage> createState() =>
      _ParapharmaProductsPageState();
}

class _ParapharmaProductsPageState
    extends State<ParapharmaProductsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: BlocBuilder<AnnouncementCubit, AnnouncementState>(
              builder: (context, state) {
                final cubit = context.read<AnnouncementCubit>();
                final products = cubit.paraPharmas;

                if (state is ParaPharmaProductsLoading && products.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ParaPharmaProductsLoaded && products.isEmpty) {
                  return EmptyListWidget();
                }

                final bool isLoadingMore = state is LoadingMoreParaPharma;
                final bool hasReachedEnd = state is ParaPharmasLoadLimitReached;

                return RefreshIndicator(
                  onRefresh: () => cubit.loadAnnouncement(),
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
                              ? () =>
                                  cubit.unlikeParaPharmaCatalog(paraPharma.id)
                              : () =>
                                  cubit.likeParaPharmaCatalog(paraPharma.id),
                        );
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
