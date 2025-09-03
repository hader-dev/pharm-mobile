import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/medical/medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';

class MedicalFilterProvider extends StatelessWidget {
  const MedicalFilterProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final medicineCubit = MarketPlaceScreen
        .marketPlaceScaffoldKey.currentContext!
        .read<MedicineProductsCubit>();
    final filterCubit = MarketPlaceScreen.marketPlaceScaffoldKey.currentContext!
        .read<MedicalFiltersCubit>();

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: filterCubit,
        ),
        BlocProvider.value(
          value: medicineCubit,
        ),
      ],
      child: BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
        builder: (context, state) {
          return child;
        },
      ),
    );
  }
}
