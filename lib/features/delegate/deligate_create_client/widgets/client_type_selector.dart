import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/decorations/field.dart';
import 'package:hader_pharm_mobile/features/common/decorations/input.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/delegate/deligate_create_client/cubit/cubit.dart'
    show DelegateCreateClientCubit;
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/validators.dart';

import '../../../common/widgets/filter_option_value.dart' show FilterOptionValueWidget;

typedef Validator = String? Function(CompanyType? client);

class ClientTypeSelector extends StatelessWidget {
  final int? selectedId;
  final ValueChanged<CompanyType?>? onChanged;
  final Validator? validator;
  final TextStyle? labelTextStyle;
  final CompanyType? currentSelection;

  const ClientTypeSelector({
    super.key,
    this.selectedId,
    this.onChanged,
    this.validator,
    this.labelTextStyle,
    this.currentSelection,
  });

  FutureOr<List<CompanyType>> itemsWithSearch(String filter, List<CompanyType> values) async {
    return values
        .where((element) =>
            element.name.toLowerCase().contains(filter.toLowerCase()) || element.name.toString().contains(filter))
        .toList();
  }

  bool compareFn(CompanyType a, CompanyType b) => a.name == b.name;

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final clients = CompanyType.values;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: context.responsiveAppSizeTheme.current.p4),
          child: Text("${translation.company_type_title}*",
              style: context.responsiveTextTheme.current.body3Medium.copyWith(color: TextColors.ternary.color)),
        ),
        const ResponsiveGap.s6(),
        DropdownButtonFormField(
          onChanged: onChanged,
          validator: (value) => requiredValidator(value?.name, translation),
          isDense: true,
          hint: Text('select company type',
              style: context.responsiveTextTheme.current.body1Regular.copyWith(color: Colors.grey)),
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
                borderSide: BorderSide(color: getEnabledBorderColor(context, FieldState.normal)),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
                borderSide: BorderSide(color: AppColors.bgDisabled),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
                borderSide: BorderSide(color: getFocusedBorderColor(context, FieldState.normal)),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
                borderSide: BorderSide(color: FieldState.error.color.primary),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
                borderSide: BorderSide(color: FieldState.error.color.primary),
              )),
          items: clients.map((e) => DropdownMenuItem(value: e, child: Text(e.name))).toList(),
        )
      ],
    );
  }
}
