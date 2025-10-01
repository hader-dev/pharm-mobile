import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/decorations/field.dart';
import 'package:hader_pharm_mobile/features/common/decorations/input.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

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

  FutureOr<List<CompanyType>> itemsWithSearch(
      String filter, List<CompanyType> values) async {
    return values
        .where((element) =>
            element.name.toLowerCase().contains(filter.toLowerCase()) ||
            element.name.toString().contains(filter))
        .toList();
  }

  Widget buildDisplayWidget(BuildContext context, CompanyType? selectedItem) {
    return Text(
      selectedItem?.name ?? context.translation!.company_type_title,
      style: context.responsiveTextTheme.current.body3Regular,
    );
  }

  bool compareFn(CompanyType a, CompanyType b) => a.name == b.name;

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final clients = CompanyType.values;

    return DropdownSearch<CompanyType>(
      validator: validator,
      selectedItem: currentSelection,
      items: (query, props) async => itemsWithSearch(query, clients),
      compareFn: compareFn,
      popupProps: PopupProps.modalBottomSheet(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: buildInputDecorationCustomFieldStyle(
              translation.select_client, FieldState.normal, context),
        ),
      ),
      itemAsString: (item) => item.name,
      dropdownBuilder: buildDisplayWidget,
      onChanged: onChanged?.call,
      decoratorProps: DropDownDecoratorProps(
        decoration: buildDropdownInputDecoration(
            context.translation!.company_type_title, context),
      ),
    );
  }
}
