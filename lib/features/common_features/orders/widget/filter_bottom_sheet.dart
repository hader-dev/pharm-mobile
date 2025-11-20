import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart' show AppLayout;
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart' show PrimaryTextButton;
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common/widgets/info_widget.dart' show InfoWidget;
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/sub_pages/review_and_sumbit/widgets/info_row.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/actions/apply_filters.dart' show applyFiltersOrder;
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/orders/orders_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/cubit/orders_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/orders.dart' show OrdersScreen;
import 'package:hader_pharm_mobile/models/order_filters.dart' show OrderFilters, OrderFiltersKeys;
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_date_helper.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;
import 'package:lucide_icons/lucide_icons.dart';

class FiltersBottomSheet extends StatelessWidget {
  const FiltersBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final translation = context.translation!;
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: AppLayout.appLayoutScaffoldKey.currentContext!.read<OrdersCubit>(),
        ),
        BlocProvider.value(
          value: OrdersScreen.scaffoldKey.currentContext!.read<OrdersFiltersCubit>(),
        ),
      ],
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          return SizedBox(
            width: context.responsiveAppSizeTheme.deviceSize.width,
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status',
                    style:
                        context.responsiveTextTheme.current.headLine5SemiBold.copyWith(color: TextColors.ternary.color),
                  ),
                  const ResponsiveGap.s12(),
                  Wrap(
                    spacing: context.responsiveAppSizeTheme.current.p8,
                    runSpacing: context.responsiveAppSizeTheme.current.p8,
                    children: OrderStatus.values.map((status) {
                      final isSelected = state.filters.status.contains(status.name);
                      return FilterChip(
                          label: Text(
                            status.name,
                            style: context.responsiveTextTheme.current.body3Regular.copyWith(
                              color: isSelected ? Colors.white : TextColors.primary.color,
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              context.read<OrdersCubit>().updatedFilters(state.filters
                                  .updateFilterList(OrderFiltersKeys.status, [...state.filters.status, status.name]));
                              return;
                            }
                            state.filters.status.removeWhere((element) => element == status.name);
                            context.read<OrdersCubit>().updatedFilters(
                                state.filters.updateFilterList(OrderFiltersKeys.status, state.filters.status));
                          },
                          selectedColor: AppColors.accent1Shade1,
                          backgroundColor: AppColors.accent1Shade1.withAlpha(30));
                    }).toList(),
                  ),
                  const ResponsiveGap.s24(),
                  CustomTextField(
                    key: ValueKey(
                        "from-${state.filters.createdAtFrom.isNotEmpty ? state.filters.createdAtFrom.first : ''}"),
                    label: translation.from,
                    hintText: translation.date,
                    hintTextStyle: context.responsiveTextTheme.current.body3Regular,
                    isReadOnly: true,
                    initValue: state.filters.createdAtFrom.isNotEmpty ? state.filters.createdAtFrom.first : null,
                    validationFunc: (value) {
                      if (value != null && state.filters.createdAtTo.isNotEmpty) {
                        final fromDate = DateTime.parse(value);
                        final toDate = DateTime.parse(state.filters.createdAtTo.first);
                        if (fromDate.isAfter(toDate)) {
                          return translation.dateRangeError;
                        }
                      }
                      return null;
                    },
                    onTap: () async {
                      DateTime? pickedDate =
                          await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime.now());

                      if (pickedDate != null) {
                        context.read<OrdersCubit>().updatedFilters(
                            state.filters.updateFilterList(OrderFiltersKeys.createdAtFrom, [pickedDate.formatYMD]));
                      }
                    },
                    suffixIcon: state.filters.createdAtFrom.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              context
                                  .read<OrdersCubit>()
                                  .updatedFilters(state.filters.updateFilterList(OrderFiltersKeys.createdAtFrom, []));
                            },
                            child: Icon(
                              Icons.close,
                              size: context.responsiveAppSizeTheme.current.p16,
                              color: TextColors.primary.color,
                            ),
                          )
                        : null,
                  ),
                  CustomTextField(
                    key: ValueKey("to-${state.filters.createdAtTo.isNotEmpty ? state.filters.createdAtTo.first : ''}"),
                    label: translation.to,
                    hintText: translation.date,
                    hintTextStyle: context.responsiveTextTheme.current.body3Regular,
                    isReadOnly: true,
                    initValue: state.filters.createdAtTo.isNotEmpty ? state.filters.createdAtTo.first : null,
                    onTap: () async {
                      DateTime? pickedDate =
                          await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime.now());

                      if (pickedDate != null) {
                        context.read<OrdersCubit>().updatedFilters(
                            state.filters.updateFilterList(OrderFiltersKeys.createdAtTo, [pickedDate.formatYMD]));
                      }
                    },
                    suffixIcon: state.filters.createdAtTo.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              context
                                  .read<OrdersCubit>()
                                  .updatedFilters(state.filters.updateFilterList(OrderFiltersKeys.createdAtTo, []));
                            },
                            child: Icon(
                              Icons.close,
                              size: context.responsiveAppSizeTheme.current.p16,
                              color: TextColors.primary.color,
                            ),
                          )
                        : null,
                  ),
                  const ResponsiveGap.s12(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p4),
                    child: Row(
                      children: [
                        Expanded(
                          child: PrimaryTextButton(
                            isOutLined: true,
                            label: translation.reset,
                            spalshColor: AppColors.accent1Shade1.withAlpha(50),
                            labelColor: AppColors.accent1Shade1,
                            borderColor: AppColors.accent1Shade1,
                            maxWidth: MediaQuery.of(context).size.width * 0.25,
                            onTap: () {
                              context.read<OrdersCubit>().resetOrderFilters();
                              state.scrollController.jumpTo(0);
                            },
                          ),
                        ),
                        const ResponsiveGap.s8(),
                        Expanded(
                          child: PrimaryTextButton(
                            label: translation.apply,
                            color: AppColors.accent1Shade1,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                context.read<OrdersCubit>().getOrders(filters: state.filters);
                                context.pop();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
