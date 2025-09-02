import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/home/cubit/home_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/home/cubit/provider.dart';
import 'package:hader_pharm_mobile/features/common_features/home/widgets/appbar.dart';
import 'package:hader_pharm_mobile/features/common_features/home/widgets/medicine/medicine_section.dart';
import 'package:hader_pharm_mobile/features/common_features/home/widgets/parapharm/para_pharma_section.dart';
import 'package:hader_pharm_mobile/features/common_features/home/widgets/vendors/vendors_section.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/vendors/cubit/vendors_cubit.dart';

import 'widgets/announcements/promotion_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minSectionHeight = MediaQuery.of(context).size.height * 0.15;

    return StateProvider(
      child: Scaffold(
        appBar: HomeAppbar(),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is PromotionLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PromotionLoadingFailed) {
              return RefreshIndicator(
                onRefresh: () => context.read<HomeCubit>().getPromotions(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Center(
                    child: EmptyListWidget(
                      onRefresh: () {
                        context.read<HomeCubit>().getPromotions();
                      },
                    ),
                  ),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () => context.read<HomeCubit>().getPromotions(),
              child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ResponsiveGap.s12(),
                      if (context.read<HomeCubit>().announcements.isNotEmpty)
                        PromotionSection(
                            announcements:
                                context.read<HomeCubit>().announcements,
                            minSectionHeight: context
                                        .read<VendorsCubit>()
                                        .vendorsList
                                        .length <
                                    4
                                ? minSectionHeight * 0.8
                                : minSectionHeight),
                      const ResponsiveGap.s12(),
                      ParapharmaSection(minSectionHeight: minSectionHeight),
                      const ResponsiveGap.s16(),
                      VendorSection(
                          minSectionHeight:
                              context.read<VendorsCubit>().vendorsList.length <
                                      4
                                  ? minSectionHeight * 0.8
                                  : minSectionHeight),
                      // Ultra-minimal spacing between vendors and medicines for phones
                      SizedBox(
                          height: MediaQuery.of(context).size.width <= 414
                              ? 1
                              : 12),
                      MedicineSection(minSectionHeight: minSectionHeight),
                      const ResponsiveGap.s12(),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }
}
