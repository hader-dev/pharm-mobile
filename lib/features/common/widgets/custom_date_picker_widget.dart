import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class CustomDatePickerWidget {
  String? startingDateFilter;
  String? endingDateFilter;
  late final bool result;
  List<DateTime> dates = [];

  CustomDatePickerWidget({
    this.startingDateFilter,
    this.endingDateFilter,
  });

  Future<void> showDatePicker(final VoidCallback? postExecuteFunc) async {
    startingDateFilter ??= "${DateTime.now().year}-01-01";
    DateTime lastDate = DateTime.parse("${DateTime.now().year}-12-31");
    result = await showDialog(
      context: RoutingManager.rootNavigatorKey.currentContext!,
      builder: (context) {
        return Material(
          color: Colors.grey.withAlpha(128),
          child: Builder(builder: (context) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSizesManager.p10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          AppSizesManager.commonWidgetsRadius),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CalendarDatePicker2(
                          config: CalendarDatePicker2WithActionButtonsConfig(
                              allowSameValueSelection: true,
                              firstDate: DateTime.parse(startingDateFilter!),
                              lastDate: lastDate,
                              daySplashColor: context.theme.primaryColor,
                              calendarType: CalendarDatePicker2Type.single),
                          value: const [],
                          onValueChanged: (value) {
                            dates = value;
                          },
                        ),
                        const ResponsiveGap.s6(),
                        Row(
                          children: [
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                GoRouter.of(context).pop(false);
                              },
                              child: Text(context.translation!.cancel),
                            ),
                            TextButton(
                              onPressed: () {
                                GoRouter.of(context).pop(true);
                              },
                              child: Text(context.translation!.confirm),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const Spacer()
                ],
              ),
            );
          }),
        );
      },
    );
    postExecuteFunc?.call();
  }
}
