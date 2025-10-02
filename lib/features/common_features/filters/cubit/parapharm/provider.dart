import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/parapharm/para_medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';

class ParaPharmFilterProvider extends StatelessWidget {
  const ParaPharmFilterProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    //TODO Refactor with a better approach using it also in Deligate Products !
    final parapharmCubit = MarketPlaceScreen
        .marketPlaceScaffoldKey.currentContext!
        .read<ParaPharmaCubit>();
    final filterCubit = MarketPlaceScreen.marketPlaceScaffoldKey.currentContext!
        .read<ParaMedicalFiltersCubit>();

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: filterCubit,
        ),
        BlocProvider.value(
          value: parapharmCubit,
        ),
      ],
      child: BlocBuilder<ParaMedicalFiltersCubit, ParaMedicalFiltersState>(
        builder: (context, state) {
          return child;
        },
      ),
    );
  }
}
