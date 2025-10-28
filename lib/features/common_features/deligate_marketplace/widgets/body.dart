import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_marketplace/cubit/marketplace_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_marketplace/cubit/marketplace_state.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_marketplace/sub_pages/items_page/items_page.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_marketplace/widgets/tabs_section.dart';

class DeligateMarketPlaceBody extends StatelessWidget {
  const DeligateMarketPlaceBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeligateMarketplaceCubit, DeligateMarketplaceState>(
        builder: (context, state) {
      if (state.pageIndex == 0) {
        return const DeligateMarketPlaceTabBarSection();
      }

      return DeligateOrderItemsPage();
    });
  }
}
