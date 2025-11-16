import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/home/actions/refresh_home.dart';
import 'package:hader_pharm_mobile/features/common_features/home/cubit/home_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/home/cubit/provider.dart';
import 'package:hader_pharm_mobile/features/common_features/home/widgets/announcements/promotion_section_v3.dart';
import 'package:hader_pharm_mobile/features/common_features/home/widgets/announcements/promotion_section_v5.dart';
import 'package:hader_pharm_mobile/features/common_features/home/widgets/announcements/promotion_section_v6.dart'
    show PromotionSectionV6;
import 'package:hader_pharm_mobile/features/common_features/home/widgets/medicine/medicine_section.dart';
import 'package:hader_pharm_mobile/features/common_features/home/widgets/parapharm/para_pharma_section.dart';
import 'package:hader_pharm_mobile/features/common_features/home/widgets/vendors/vendors_section.dart';

import 'widgets/announcements/promotion_section_v4.dart' show PromotionSectionV4;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
    final screenSize = MediaQuery.of(context).size;
    final minSectionHeight = screenSize.height * 0.15;

    final sectionHeightModifier = screenSize.width <= DeviceSizes.mediumMobile.width ? 2 : 2.2;

    return StateProvider(
      child: Scaffold(
        key: HomeScreen.scaffoldKey,
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is PromotionLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is PromotionLoadingFailed) {
              return RefreshIndicator(
                onRefresh: () => refreshHome(context),
                child: Center(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: EmptyListWidget(
                      onRefresh: () {
                        refreshHome(context);
                      },
                    ),
                  ),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () => refreshHome(context),
              child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ResponsiveGap.s12(),
                      if (state.announcements.isNotEmpty)
                        PromotionSectionV6(
                            announcements: state.announcements.length > 4
                                ? state.announcements.sublist(0, 4)
                                : state.announcements,
                            minSectionHeight: minSectionHeight),
                      ParaPharmaSection(minSectionHeight: minSectionHeight * sectionHeightModifier),
                      const VendorSection(),
                      MedicineSection(minSectionHeight: minSectionHeight * sectionHeightModifier),
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
