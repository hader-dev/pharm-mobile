import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/para_medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/models/para_medical_filters.dart';

void navigateToParaFiltersApplyView(BuildContext context, ParaMedicalFiltersKeys key) {
  context.read<ParaMedicalFiltersCubit>().goToApplyFilters(key);
}
