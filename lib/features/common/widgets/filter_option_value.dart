import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../config/theme/colors_manager.dart';

class FilterOptionValueWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback? onSelected;
  const FilterOptionValueWidget(
      {super.key,
      this.title = 'Default',
      this.isSelected = false,
      this.onSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onSelected,
      child: Container(
        padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p12),
        child: Row(
          children: [
            Text(
              title,
              style: context.responsiveTextTheme.current.body3Medium,
            ),
            Spacer(),
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: isSelected
                          ? AppColors.accent1Shade1
                          : StrokeColors.normal.color,
                      width: 1),
                  shape: BoxShape.circle),
              child: Center(
                child: Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.accent1Shade1
                            : Colors.transparent,
                        shape: BoxShape.circle)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
