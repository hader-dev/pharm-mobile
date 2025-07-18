import 'package:gap/gap.dart';

import '../../../../config/language_config/cubit/lang_cubit.dart';
import '../../../../config/language_config/cubit/lang_state.dart';
import '../../../../config/theme/colors_manager.dart';
import '../../../../config/theme/typoghrapy_manager.dart';
import '../../../../utils/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LangTile extends StatelessWidget {
  final String langValue;

  final String langName;
  final String langImgPath;
  const LangTile({super.key, required this.langValue, required this.langName, required this.langImgPath});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LangCubit, LangState>(
      builder: (BuildContext context, LangState state) {
        return InkWell(
          onTap: () {
            BlocProvider.of<LangCubit>(context).changeLang(langValue);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: AppSizesManager.p6),
            padding: const EdgeInsets.all(AppSizesManager.p6),
            child: Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    right: AppSizesManager.p8,
                    left: AppSizesManager.p6,
                    top: AppSizesManager.p6,
                    bottom: AppSizesManager.p6),
                child: SvgPicture.asset(
                  langImgPath,
                  height: AppSizesManager.iconSize20 * 2.3,
                  width: AppSizesManager.iconSize20 * 2.3,
                ),
              ),
              Gap(AppSizesManager.s12),
              Text(
                langName,
                style: AppTypography.body1MediumStyle.copyWith(color: TextColors.primary.color),
              ),
              const Spacer(),
              if (context.read<LangCubit>().appLang == langValue)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p6),
                  child: Icon(
                    Icons.check,
                    size: AppSizesManager.iconSize20,
                  ),
                )
            ]),
          ),
        );
      },
    );
  }
}
