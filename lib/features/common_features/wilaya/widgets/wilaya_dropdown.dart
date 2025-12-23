import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/decorations/field.dart';
import 'package:hader_pharm_mobile/features/common/decorations/input.dart';
import 'package:hader_pharm_mobile/models/wilaya.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

typedef OnWilayaCallback = void Function(Wilaya? selectedItem);
typedef WilayaValidator = String? Function(Wilaya? selectedItem);

class BaseWilayaDropdown extends StatelessWidget {
  const BaseWilayaDropdown(
      {super.key,
      required this.wilayas,
      this.onChanged,
      this.currentSelection,
      this.labelTextStyle,
      this.isRequired = false,
      this.validator});

  final List<Wilaya> wilayas;
  final OnWilayaCallback? onChanged;
  final WilayaValidator? validator;
  final TextStyle? labelTextStyle;
  final Wilaya? currentSelection;
  final bool isRequired;

  FutureOr<List<Wilaya>> itemsWithSearch(String filter, LoadProps? loadProps) async {
    return wilayas
        .where((element) =>
            element.label.toLowerCase().contains(filter.toLowerCase()) || element.id.toString().contains(filter))
        .toList();
  }

  Widget buildDisplayWidget(BuildContext context, Wilaya? selectedItem) {
    return Text(
      selectedItem?.label ?? context.translation!.select_wilaya,
      style: context.responsiveTextTheme.current.body3Regular,
    );
  }

  bool compareFn(Wilaya a, Wilaya b) => a.id == b.id;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Wilaya>(
      validator: validator,
      selectedItem: currentSelection,
      items: itemsWithSearch,
      compareFn: compareFn,
      popupProps: PopupProps.modalBottomSheet(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration:
              buildInputDecorationCustomFieldStyle(context.translation!.select_wilaya, FieldState.normal, context),
        ),
      ),
      itemAsString: (item) => item.label,
      dropdownBuilder: buildDisplayWidget,
      onChanged: onChanged?.call,
      decoratorProps: DropDownDecoratorProps(
        decoration: buildDropdownInputDecoration(context.translation!.select_wilaya, context),
      ),
    );
  }
}
