import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/clients/cubit/clients_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/clients/cubit/provider.dart';
import 'package:hader_pharm_mobile/features/common_features/clients/widgets/add_client_btn.dart';
import 'package:hader_pharm_mobile/features/common_features/clients/widgets/appbar.dart';
import 'package:hader_pharm_mobile/features/common_features/clients/widgets/deligate_client.widget.dart';
import 'package:hader_pharm_mobile/features/common_features/clients/widgets/search_widget.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DeligateClientsStateProvider(
      child: SafeArea(
        child: Scaffold(
          appBar: const DeligateClientsAppbar(),
          floatingActionButton: const AddClientBtn(),
          body: BlocBuilder<DeligateClientsCubit, DeligateClientsState>(
              builder: (context, state) {
            return Column(
              children: [
                const ClientDeligateSearchWidget(),
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
