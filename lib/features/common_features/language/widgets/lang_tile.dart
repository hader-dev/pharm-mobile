import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hader_pharm_mobile/config/language_config/cubit/lang_cubit.dart';
import 'package:hader_pharm_mobile/config/language_config/cubit/lang_state.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class LangTile extends StatelessWidget {
  final String langValue;

  final String langName;
  final String langImgPath;
  const LangTile(
      {super.key,
      required this.langValue,
      required this.langName,
      required this.langImgPath});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LangCubit, LangState>(
      builder: (BuildContext context, LangState state) {
        return InkWell(
          onTap: () {
            BlocProvider.of<LangCubit>(context).changeLang(langValue);
          },
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: context.responsiveAppSizeTheme.current.p6),
            padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p6),
            child: Row(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    right: context.responsiveAppSizeTheme.current.p8,
                    left: context.responsiveAppSizeTheme.current.p6,
                    top: context.responsiveAppSizeTheme.current.p6,
                    bottom: context.responsiveAppSizeTheme.current.p6),
                child: SvgPicture.asset(
                  langImgPath,
                  height:
                      context.responsiveAppSizeTheme.current.iconSize20 * 2.3,
                  width:
                      context.responsiveAppSizeTheme.current.iconSize20 * 2.3,
                ),
              ),
              const ResponsiveGap.s12(),
              Text(
                langName,
                style: context.responsiveTextTheme.current.body1Medium
                    .copyWith(color: TextColors.primary.color),
              ),
              const Spacer(),
              if (context.read<LangCubit>().appLang == langValue)
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveAppSizeTheme.current.p6),
                  child: Icon(
                    Icons.check,
                    size: context.responsiveAppSizeTheme.current.iconSize20,
                  ),
                )
            ]),
          ),
        );
      },
    );
  }
}
