import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/language_config/cubit/lang_cubit.dart';
import 'package:hader_pharm_mobile/config/language_config/cubit/lang_state.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import 'widgets/lang_tile.dart';

class LanguagesScreen extends StatelessWidget {
  const LanguagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocProvider.value(
        value: BlocProvider.of<LangCubit>(RoutingManager.rootNavigatorKey.currentContext!),
        child: Scaffold(
          appBar: CustomAppBarV2.normal(
            leading: IconButton(
              icon: Icon(
                Directionality.of(context) == TextDirection.rtl ? Iconsax.arrow_right_3 : Iconsax.arrow_left_2,
                color: AppColors.accent1Shade1,
                size: context.responsiveAppSizeTheme.current.iconSize25,
              ),
              onPressed: () {
                context.pop();
              },
            ),
            title: Text(context.translation!.language,
                style: context.responsiveTextTheme.current.body1Medium.copyWith(
                  color: AppColors.accent1Shade1,
                )),
          ),
          body: SafeArea(
            child: BlocListener<LangCubit, LangState>(
              listener: (BuildContext context, LangState state) {
                if (state is LangSettingsSaved) {
                  context.pop();
                }
              },
              child: BlocBuilder<LangCubit, LangState>(
                builder: (BuildContext context, LangState state) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: context.responsiveAppSizeTheme.current.p8,
                      right: context.responsiveAppSizeTheme.current.p8,
                      bottom: context.responsiveAppSizeTheme.current.p8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: context.responsiveAppSizeTheme.current.p10,
                        ),
                        Text(context.translation!.select_language_description,
                            style: context.responsiveTextTheme.current.body1Medium.copyWith(
                              color: TextColors.ternary.color,
                            )),
                        SizedBox(
                          height: context.responsiveAppSizeTheme.current.p10,
                        ),
                        const LangTile(
                          langName: 'العربية',
                          langImgPath: DrawableAssetStrings.saudiFlagIcon,
                          langValue: 'ar',
                        ),
                        const LangTile(
                          langName: 'English',
                          langImgPath: DrawableAssetStrings.usaFlagIcon,
                          langValue: 'en',
                        ),
                        const LangTile(
                          langName: 'Français',
                          langImgPath: DrawableAssetStrings.franceFlagIcon,
                          langValue: 'fr',
                        ),
                        SizedBox(
                          height: context.responsiveAppSizeTheme.current.p10 * 2,
                        ),
                        const Spacer(),
                        PrimaryTextButton(
                          label: context.translation!.save,
                          labelColor: AppColors.bgWhite,
                          onTap: () {
                            BlocProvider.of<LangCubit>(context).saveLangSettings();
                          },
                          color: AppColors.accent1Shade1,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}
