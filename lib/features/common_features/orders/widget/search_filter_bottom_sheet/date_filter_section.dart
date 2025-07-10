import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:hader_pharm_mobile/utils/extensions/app_date_helper.dart';

import '../../../../../config/theme/colors_manager.dart' show AppColors, SystemColors;
import '../../../../../config/theme/typoghrapy_manager.dart' show AppTypography;
import '../../../../../utils/constants.dart';

import '../../../../common/widgets/custom_date_picker_widget.dart';
import '../../../para_pharma_catalog_details/widgets/make_order_bottom_sheet.dart' show InfoWidget;
import '../../cubit/orders_cubit.dart';

class DateFilterSection extends StatelessWidget {
  CustomDatePickerWidget datePicker = CustomDatePickerWidget();
  DateFilterSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      label: "Date : ",
      bgColor: AppColors.bgWhite,
      value: Padding(
        padding: const EdgeInsets.only(top: AppSizesManager.p16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              onTap: () async {
                await datePicker.showDatePicker(
                  () {
                    if (datePicker.result)
                      BlocProvider.of<OrdersCubit>(context)
                          .updateDateFilter(initialDate: datePicker.dates.first.formatYMD);
                  },
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Initial date",
                        style: AppTypography.body2MediumStyle,
                      ),
                      if (BlocProvider.of<OrdersCubit>(context).initialDateFilter != null)
                        Transform.scale(
                          scale: 0.8,
                          child: IconButton(
                            onPressed: () => BlocProvider.of<OrdersCubit>(context)
                                .updateDateFilter(initialDate: "", removeValue: true),
                            icon: Icon(
                              Icons.clear,
                              color: SystemColors.red.primary,
                              size: AppSizesManager.iconSize20,
                            ),
                          ),
                        )
                    ],
                  ),
                  const Gap(AppSizesManager.s8),
                  Text(
                    BlocProvider.of<OrdersCubit>(context).initialDateFilter ?? "Tap to select",
                    style: AppTypography.body2MediumStyle.copyWith(color: AppColors.accent1Shade1),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_right_alt,
              color: Colors.grey,
              size: AppSizesManager.iconSize25,
            ),
            InkWell(
              onTap: () async {
                await datePicker.showDatePicker(
                  () {
                    if (datePicker.result)
                      BlocProvider.of<OrdersCubit>(context)
                          .updateDateFilter(finalDate: datePicker.dates.first.formatYMD);
                  },
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Final date",
                            style: AppTypography.body2MediumStyle,
                          ),
                          if (BlocProvider.of<OrdersCubit>(context).finalDateFilter != null)
                            Transform.scale(
                              scale: 0.8,
                              child: IconButton(
                                onPressed: () => BlocProvider.of<OrdersCubit>(context)
                                    .updateDateFilter(finalDate: "", removeValue: true),
                                icon: Icon(
                                  Icons.clear,
                                  color: SystemColors.red.primary,
                                  size: AppSizesManager.iconSize20,
                                ),
                              ),
                            )
                        ],
                      ),
                    ],
                  ),
                  const Gap(AppSizesManager.s8),
                  Text(
                    BlocProvider.of<OrdersCubit>(context).finalDateFilter ?? "Tap to select",
                    style: AppTypography.body2MediumStyle.copyWith(color: AppColors.accent1Shade1),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
