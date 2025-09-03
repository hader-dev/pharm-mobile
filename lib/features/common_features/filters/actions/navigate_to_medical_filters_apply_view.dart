import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/medical/medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/models/medical_filters.dart';

void navigateToMedicalFiltersApplyView(BuildContext context, MedicalFiltersKeys key) {
  context.read<MedicalFiltersCubit>().goToApplyFilters(key);
}
