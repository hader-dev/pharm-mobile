import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common_features/home/cubit/home_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/vendors/cubit/vendors_cubit.dart';

Future<void> refreshHome(BuildContext context) async {
  await Future.wait([
    context.read<HomeCubit>().getPromotions(),
    context.read<ParaPharmaCubit>().getParaPharmas(),
    context.read<MedicineProductsCubit>().getMedicines(),
    context.read<VendorsCubit>().fetchVendors(),
  ]);
}
