import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';

import '../../../../../config/services/network/network_interface.dart';
import '../../../../../repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';
import '../../../../common/widgets/empty_list.dart';
import '../../../../common/widgets/end_of_load_result_widget.dart';
import '../../../../common/widgets/para_pharma_widget_2.dart';
import 'cubit/para_pharma_cubit.dart';

class ParaPharmaPage extends StatefulWidget {
  const ParaPharmaPage({super.key});

  @override
  State<ParaPharmaPage> createState() => _ParaPharmaPageState();
}

class _ParaPharmaPageState extends State<ParaPharmaPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => ParaPharmaCubit(
          scrollController: ScrollController(),
          paraPharmaRepository: ParaPharmaRepository(client: getItInstance.get<INetworkService>()))
        ..getParaPharmas(),
      child: Material(child: BlocBuilder<ParaPharmaCubit, ParaPharmaState>(
        builder: (context, state) {
          if (state is ParaPharmaProductsLoading) {
            // return const LoadingWidget();
          }
          if (state is ParaPharmaProductsLoaded &&
              BlocProvider.of<ParaPharmaCubit>(context).paraPharmaProducts.isEmpty) {
            return EmptyListWidget();
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: RefreshIndicator(
                    onRefresh: () {
                      return BlocProvider.of<ParaPharmaCubit>(context).getParaPharmas();
                    },
                    child: ListView.builder(
                      controller: BlocProvider.of<ParaPharmaCubit>(context).scrollController,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: BlocProvider.of<ParaPharmaCubit>(context).paraPharmaProducts.length,
                      itemBuilder: (context, index) => ParaPharmaWidget2(
                        paraPharmData: BlocProvider.of<ParaPharmaCubit>(context).paraPharmaProducts[index],
                      ),
                    )),
              ),
              if (state is LoadingMoreParaPharma) const Center(child: CircularProgressIndicator()),
              if (state is ParaPharmasLoadLimitReached) EndOfLoadResultWidget(),
            ],
          );
        },
      )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
