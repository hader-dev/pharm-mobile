import 'package:flutter/widgets.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';

import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class Board extends StatelessWidget {
  final Widget img;
  final String title;
  final String description;
  const Board({super.key, required this.img, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60), // Adjust the radius as needed
            child: img,
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(bottom: AppSizesManager.p24, left: AppSizesManager.p24, right: AppSizesManager.p24),
          child: Column(
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTypography.headLine1Style,
              ),
              const SizedBox(
                height: AppSizesManager.p16,
              ),
              Text(description,
                  textAlign: TextAlign.center,
                  style: AppTypography.body1MediumStyle.copyWith(
                    color: TextColors.ternary.color,
                    height: 1.7,
                  )),
            ],
          ),
        )
      ],
    );
  }
}
