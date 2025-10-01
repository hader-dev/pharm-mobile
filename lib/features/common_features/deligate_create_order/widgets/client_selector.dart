import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/decorations/field.dart';
import 'package:hader_pharm_mobile/features/common/decorations/input.dart';
import 'package:hader_pharm_mobile/features/common_features/clients/cubit/clients_cubit.dart';
import 'package:hader_pharm_mobile/models/client.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

typedef DeligateClientValidator = String? Function(DeligateClient? client);

class OrderClientSelector extends StatelessWidget {
  final String? selectedClientId;
  final ValueChanged<DeligateClient?>? onChanged;
  final DeligateClientValidator? validator;
  final TextStyle? labelTextStyle;
  final DeligateClient? currentSelection;

  const OrderClientSelector({
    super.key,
    this.selectedClientId,
    this.onChanged,
    this.validator,
    this.labelTextStyle,
    this.currentSelection,
  });

  FutureOr<List<DeligateClient>> itemsWithSearch(
      String filter, List<DeligateClient> values) async {
    return values
        .where((element) =>
            element.buyerCompany.name
                .toLowerCase()
                .contains(filter.toLowerCase()) ||
            element.buyerCompany.name.toString().contains(filter))
        .toList();
  }

  Widget buildDisplayWidget(
      BuildContext context, DeligateClient? selectedItem) {
    return Text(
      selectedItem?.buyerCompany.name ?? context.translation!.select_client,
      style: context.responsiveTextTheme.current.body3Regular,
    );
  }

  bool compareFn(DeligateClient a, DeligateClient b) => a.id == b.id;

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return BlocBuilder<DeligateClientsCubit, DeligateClientsState>(
      builder: (context, state) => DropdownSearch<DeligateClient>(
        validator: validator,
        selectedItem: currentSelection,
        items: (query, props) async => itemsWithSearch(query, state.clients),
        compareFn: compareFn,
        popupProps: PopupProps.modalBottomSheet(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: buildInputDecorationCustomFieldStyle(
                translation.select_client, FieldState.normal, context),
          ),
        ),
        itemAsString: (item) => item.buyerCompany.name,
        dropdownBuilder: buildDisplayWidget,
        onChanged: onChanged?.call,
        decoratorProps: DropDownDecoratorProps(
          decoration: buildDropdownInputDecoration(
              context.translation!.select_client, context),
        ),
      ),
    );
  }
}
