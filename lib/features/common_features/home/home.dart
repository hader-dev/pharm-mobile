import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/home/cubit/home_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/home/cubit/provider.dart';
import 'package:hader_pharm_mobile/features/common_features/home/widgets/announcements/promotion_section_v4.dart';
import 'package:hader_pharm_mobile/features/common_features/home/widgets/appbar.dart';
import 'package:hader_pharm_mobile/features/common_features/home/widgets/medicine/medicine_section.dart';
import 'package:hader_pharm_mobile/features/common_features/home/widgets/parapharm/para_pharma_section.dart';
import 'package:hader_pharm_mobile/features/common_features/home/widgets/vendors/vendors_section.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

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
        key: HomeScreen.scaffoldKey,
        appBar: const HomeAppbar(),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is PromotionLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PromotionLoadingFailed) {
              return RefreshIndicator(
                onRefresh: () => context.read<HomeCubit>().getPromotions(),
                child: Center(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
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
                      const ResponsiveGap.s24(),
                      if (state.announcements.isNotEmpty)
                        PromotionSectionV4(
                            announcements: state.announcements,
                            minSectionHeight: context.deviceSize.width <=
                                    DeviceSizes.mediumMobile.width
                                ? minSectionHeight * 1.4
                                : minSectionHeight),
                      const ResponsiveGap.s12(),
                      ParapharmaSection(minSectionHeight: minSectionHeight),
                      const ResponsiveGap.s12(),
                      const VendorSection(),
                      const ResponsiveGap.s12(),
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
