import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/shimmers/vendor_widget_shimmer_2.dart' show VendorWidgetShimmer2;
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/vendor_item.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'cubit/vendors_cubit.dart';
import 'widgets/filters_bar.dart' show FiltersBar;

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
      child: Padding(
        padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
        child: Column(
          children: [
            FiltersBar(),
            Expanded(
              child: BlocBuilder<VendorsCubit, VendorsState>(
                builder: (context, state) {
                  final cubit = BlocProvider.of<VendorsCubit>(context);
                  final vendors = state.vendorsList;

                  if (state is VendorsLoading) {
                    return ListView(shrinkWrap: true, children: List.generate(4, (_) => VendorWidgetShimmer2()));
                  }

                  if (state is VendorsLoaded && vendors.isEmpty) {
                    return Center(
                        child: EmptyListWidget(
                      onRefresh: () => cubit.fetchVendors(searchValue: state.searchController.text),
                    ));
                  }

                  final bool isLoadingMore = state is VendorsLoadingMore;
                  final bool hasReachedEnd = state is VendorsLoadLimitReached;

                  return RefreshIndicator(
                    onRefresh: () => cubit.fetchVendors(searchValue: state.searchController.text),
                    child: ListView.builder(
                      controller: cubit.scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: vendors.length + (isLoadingMore || hasReachedEnd ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < vendors.length) {
                          return VendorItem(
                              companyData: vendors[index],
                              onLike: () => cubit.likeVendor(vendors[index].id),
                              onRemoveFromFavorites: () => cubit.unlikeVendor(
                                    vendors[index].id,
                                  ));
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
