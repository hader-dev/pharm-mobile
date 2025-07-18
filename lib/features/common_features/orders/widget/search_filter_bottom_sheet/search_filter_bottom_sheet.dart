import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart' show AppLayout;

import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;

import '../../../../../../../utils/enums.dart';
import '../../../../common/buttons/solid/primary_text_button.dart';
import '../../../../common/widgets/bottom_sheet_header.dart';
import '../../../../common/widgets/info_widget.dart' show InfoWidget;
import '../../cubit/orders_cubit.dart' show OrdersCubit, OrdersState;
import 'date_filter_section.dart' show DateFilterSection;
import 'price_filter_section.dart' show PriceFilterSection;

class OrdersFilterBottomSheet extends StatelessWidget {
  const OrdersFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: AppLayout.appLayoutScaffoldKey.currentContext!.read<OrdersCubit>(),
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          //  if (state is! MedicineSearchFilterChanged) {}
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BottomSheetHeader(title: 'Search Filters'),
              Gap(AppSizesManager.s12),
              Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
              Gap(AppSizesManager.s12),
              InfoWidget(
                  label: "Status : ",
                  bgColor: AppColors.bgWhite,
                  value: Wrap(
                    // shrinkWrap: true,
                    children: [
                      ChoiceChip(
                          label: Text("All"),
                          selectedColor: AppColors.accent1Shade1.withAlpha(150),
                          selected: BlocProvider.of<OrdersCubit>(context).selectedStatusFilters.length ==
                              OrderStatus.values.length,
                          onSelected: (value) {
                            BlocProvider.of<OrdersCubit>(context).updateStatusFilter(-1);
                          }),
                      ...OrderStatus.values.map((status) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p4),
                            child: ChoiceChip(
                                selectedColor: AppColors.accent1Shade1.withAlpha(150),
                                label: Text(status.name),
                                selected:
                                    BlocProvider.of<OrdersCubit>(context).selectedStatusFilters.contains(status.id),
                                onSelected: (value) {
                                  BlocProvider.of<OrdersCubit>(context).updateStatusFilter(status.id);
                                }),
                          ))
                    ],
                  )),
              Gap(AppSizesManager.s12),
              PriceFilterSection(),
              DateFilterSection(),
              Gap(AppSizesManager.s12),
              Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
              Gap(AppSizesManager.s12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p4),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: PrimaryTextButton(
                        isOutLined: true,
                        label: context.translation!.reset,
                        labelColor: AppColors.accent1Shade1,
                        onTap: () {
                          BlocProvider.of<OrdersCubit>(context).resetFilters();
                        },
                        borderColor: AppColors.accent1Shade1,
                      ),
                    ),
                    Gap(AppSizesManager.s8),
                    Expanded(
                      flex: 2,
                      child: PrimaryTextButton(
                        label: context.translation!.apply,
                        leadingIcon: Iconsax.money4,
                        onTap: () {
                          BlocProvider.of<OrdersCubit>(context).applyFilters();
                          context.pop();
                        },
                        color: AppColors.accent1Shade1,
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
