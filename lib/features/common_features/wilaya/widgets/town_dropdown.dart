import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/decorations/field.dart';
import 'package:hader_pharm_mobile/features/common/decorations/input.dart';
import 'package:hader_pharm_mobile/models/wilaya.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

typedef OnChangedCallback = void Function(Town? selectedItem);
typedef TownValidator = String? Function(Town? selectedItem);

class BaseTownDropdown extends StatelessWidget {
  const BaseTownDropdown(
      {super.key,
      required this.towns,
      this.onChanged,
      this.currentSelection,
      this.labelTextStyle,
      this.validator});

  final List<Town> towns;
  final OnChangedCallback? onChanged;
  final TownValidator? validator;
  final TextStyle? labelTextStyle;
  final Town? currentSelection;

  FutureOr<List<Town>> itemsWithSearch(
      String filter, LoadProps? loadProps) async {
    return towns
        .where((element) =>
            element.label.toLowerCase().contains(filter.toLowerCase()) ||
            element.id.toString().contains(filter))
        .toList();
  }

  Widget buildDisplayWidget(BuildContext context, Town? selectedItem) {
    return Text(
      selectedItem?.label ?? context.translation!.select_town,
      style: context.responsiveTextTheme.current.body3Regular,
    );
  }

  bool compareFn(Town a, Town b) => a.id == b.id;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Town>(
      validator: validator,
      selectedItem: currentSelection,
      items: itemsWithSearch,
      compareFn: compareFn,
      popupProps: PopupProps.modalBottomSheet(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: buildInputDecorationCustomFieldStyle(
              context.translation!.select_town, FieldState.normal, context),
        ),
      ),
      itemAsString: (item) => item.label,
      dropdownBuilder: buildDisplayWidget,
      onChanged: onChanged?.call,
      decoratorProps: DropDownDecoratorProps(
        decoration: buildDropdownInputDecoration(
            context.translation!.select_town, context),
      ),
    );
  }
}
