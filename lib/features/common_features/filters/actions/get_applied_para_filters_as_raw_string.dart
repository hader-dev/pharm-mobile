import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/para_medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/models/para_medical_filters.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

String getDisplayedParaFiltersAsRawString(BuildContext context, ParaMedicalFiltersKeys currentkey) {
  final formated = context.read<ParaMedicalFiltersCubit>().appliedFilters.getFilterBykey(currentkey).join(', ');

  return formated.isNotEmpty ? formated : context.translation!.any;
}
