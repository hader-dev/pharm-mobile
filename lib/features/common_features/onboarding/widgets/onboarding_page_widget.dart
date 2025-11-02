import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class Board extends StatelessWidget {
  final Widget img;
  final String title;
  final String description;
  const Board(
      {super.key,
      required this.img,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(30.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: img,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              bottom: context.responsiveAppSizeTheme.current.p24,
              left: context.responsiveAppSizeTheme.current.p24,
              right: context.responsiveAppSizeTheme.current.p24),
          child: Column(
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.center,
                style: context.responsiveTextTheme.current.headLine1,
              ),
              SizedBox(
                height: context.responsiveAppSizeTheme.current.p16,
              ),
              Text(description,
                  textAlign: TextAlign.center,
                  style:
                      context.responsiveTextTheme.current.body1Medium.copyWith(
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
