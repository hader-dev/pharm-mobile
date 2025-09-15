import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/vendor_item.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

import 'cubit/vendors_cubit.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(AppSizesManager.p8),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<VendorsCubit, VendorsState>(
                builder: (context, state) {
                  final cubit = BlocProvider.of<VendorsCubit>(context);
                  final vendors = cubit.vendorsList;

                  if (state is VendorsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final bool isLoadingMore = state is VendorsLoadingMore;
                  final bool hasReachedEnd = state is VendorsLoadLimitReached;

                  // Always wrap with RefreshIndicator, even when empty
                  return RefreshIndicator(
                    onRefresh: () => cubit.fetchVendors(),
                    child: vendors.isEmpty
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
                            itemCount: vendors.length +
                                (isLoadingMore || hasReachedEnd ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index < vendors.length) {
                                return VendorItem(companyData: vendors[index]);
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
