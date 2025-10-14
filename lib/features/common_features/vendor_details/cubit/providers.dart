import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/parapharm/para_medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/vendor_details/vendor_details.dart';

class ParaPharmFilterProvider extends StatelessWidget {
  const ParaPharmFilterProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final parapharmCubit = VendorDetails
        .vendorDetailsScaffoldKey.currentContext!
        .read<ParaPharmaCubit>();
    final filterCubit = VendorDetails.vendorDetailsScaffoldKey.currentContext!
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
      child: BlocBuilder<ParaPharmaCubit, ParaPharmaState>(
          builder: (context, state) {
        return child;
      }),
    );
  }
}
