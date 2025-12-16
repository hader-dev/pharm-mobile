import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_clients/cubit/clients_cubit.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_clients/cubit/provider.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_clients/widgets/add_client_btn.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_clients/widgets/delegate_client.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_clients/widgets/search_widget.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DelegateClientsStateProvider(
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: const AddClientBtn(),
          body: BlocBuilder<DelegateClientsCubit, DelegateClientsState>(builder: (context, state) {
            return Column(
              children: [
                const ClientDeligateSearchWidget(),
                if (state.clients.isEmpty)
                  Center(
                    child: RefreshIndicator(
                      onRefresh: () => context.read<DelegateClientsCubit>().getClients(),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: EmptyListWidget(
                          onRefresh: () => context.read<DelegateClientsCubit>().getClients(),
                        ),
                      ),
                    ),
                  ),
                if (state.clients.isNotEmpty)
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => context.read<DelegateClientsCubit>().getClients(),
                      child: ListView.builder(
                        itemBuilder: (context, index) => DelegateClientWidget(
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
