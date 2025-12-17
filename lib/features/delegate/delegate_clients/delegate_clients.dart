import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/shimmers/delegate_client_widget_shimmer.dart'
    show DelegateClientWidgetShimmer;
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_clients/cubit/delegate_clients_cubit.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_clients/cubit/provider.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_clients/widgets/add_client_btn.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_clients/widgets/delegate_client.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_clients/widgets/search_widget.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'widgets/appbar.dart' show DelegateClientsAppBar;

class ClientScreen extends StatelessWidget {
  const ClientScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DelegateClientsStateProvider(
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: const AddNewClientBtn(),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p8),
            child: Column(
              children: [
                const ClientDelegateSearchWidget(),
                BlocBuilder<DelegateClientsCubit, DelegateClientsState>(builder: (context, state) {
                  if (state is ClientsLoading) {
                    return ListView(shrinkWrap: true, children: List.generate(4, (_) => DelegateClientWidgetShimmer()));
                  }
                  if (state is ClientsLoaded && state.clients.isEmpty) {
                    return Center(
                      child: RefreshIndicator(
                        onRefresh: () => context.read<DelegateClientsCubit>().getClients(),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: EmptyListWidget(
                            onRefresh: () => context.read<DelegateClientsCubit>().getClients(),
                          ),
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => context.read<DelegateClientsCubit>().getClients(),
                      child: ListView.builder(
                        itemBuilder: (context, index) => DelegateClientWidget(
                          client: state.clients[index],
                        ),
                        itemCount: state.totalItemsCount,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
