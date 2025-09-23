import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/clients/cubit/clients_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/clients/cubit/provider.dart';
import 'package:hader_pharm_mobile/features/common_features/clients/widgets/deligate_client.widget.dart';
import 'package:hader_pharm_mobile/features/common_features/clients/widgets/search_widget.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DeligateStateProvider(
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBarV2.alternate(
            topPadding: MediaQuery.of(context).padding.top,
            bottomPadding: MediaQuery.of(context).padding.bottom,
            leading: IconButton(
              icon: const Icon(
                Iconsax.bag_2,
                size: AppSizesManager.iconSize25,
                color: AppColors.bgWhite,
              ),
              onPressed: () {},
            ),
            title: Text(
              context.translation!.client,
              style: context.responsiveTextTheme.current.headLine3SemiBold
                  .copyWith(color: AppColors.bgWhite),
            ),
          ),
          body: BlocBuilder<DeligateClientsCubit, DeligateClientsState>(
              builder: (context, state) {
            return Column(
              children: [
                ClientDeligateSearchWidget(),
                if (state.clients.isEmpty)
                  Center(
                    child: RefreshIndicator(
                      onRefresh: () =>
                          context.read<DeligateClientsCubit>().getClients(),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: EmptyListWidget(
                          onRefresh: () =>
                              context.read<DeligateClientsCubit>().getClients(),
                        ),
                      ),
                    ),
                  ),
                if (state.clients.isNotEmpty)
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () =>
                          context.read<DeligateClientsCubit>().getClients(),
                      child: ListView.builder(
                        itemBuilder: (context, index) => DeligateClientWidget(
                          client: state.clients[index],
                        ),
                        itemCount: state.totalItemsCount,
                      ),
                    ),
                  )
              ],
            );
          }),
        ),
      ),
    );
  }
}
