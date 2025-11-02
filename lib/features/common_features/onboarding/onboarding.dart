import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'cubit/onboarding_cubit.dart';
import 'widgets/onboarding_page_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    final translations = context.translation!;

    List<Widget> pages = <Widget>[
      Board(
        img: SizedBox(
          child: Image.asset(
            DrawableAssetStrings.board1Img,
            fit: BoxFit.fill,
          ),
        ),
        title: translations.find_medicines,
        description: translations.onboarding_find_medicines_descirption,
      ),
      Board(
        img: SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 2.5 / 6,
          child: Image.asset(
            DrawableAssetStrings.board2Img,
            fit: BoxFit.fill,
          ),
        ),
        title: translations.onboarding_seamless_shopping,
        description: translations.onboarding_seamless_shopping_desc,
      ),
      Board(
        img: SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 2.5 / 6,
          child: Image.asset(
            DrawableAssetStrings.board3Img,
            fit: BoxFit.fill,
          ),
        ),
        title: translations.onboarding_get_started,
        description: translations.onboarding_get_started_desc,
      ),
    ];

    return BlocProvider(
      create: (BuildContext context) =>
          OnboardingCubit()..initPagesCount(pages.length),
      child: Scaffold(
        backgroundColor: AppColors.bgWhite,
        body: SafeArea(child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (BuildContext context, OnboardingState state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: PageView(
                      onPageChanged: (int value) {
                        cubit.onPageChanged(value);
                      },
                      physics: const BouncingScrollPhysics(),
                      controller: state.pageController,
                      children: pages),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: context.responsiveAppSizeTheme.current.p16),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  context.responsiveAppSizeTheme.current.p8),
                          child: SmoothPageIndicator(
                            controller: state.pageController,
                            effect: WormEffect(
                                dotHeight: 5,
                                dotWidth: 15,
                                activeDotColor: context.theme.primaryColor,
                                dotColor:
                                    context.theme.primaryColor.withAlpha(51)),
                            count: pages.length,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: context.responsiveAppSizeTheme.current.p12,
                            left: context.responsiveAppSizeTheme.current.p12,
                            right: context.responsiveAppSizeTheme.current.p12,
                          ),
                          width: double.maxFinite,
                          height: context
                              .responsiveAppSizeTheme.current.buttonHeight,
                          child: PrimaryTextButton(
                            height: context
                                .responsiveAppSizeTheme.current.buttonHeight,
                            label: context
                                        .watch<OnboardingCubit>()
                                        .state
                                        .currentIndex <
                                    pages.length - 1
                                ? translations.next
                                : translations.start,
                            color: context.theme.primaryColor,
                            onTap: () async {
                              state.currentIndex < pages.length - 1
                                  ? await context
                                      .read<OnboardingCubit>()
                                      .nextPage()
                                  : context
                                      .read<OnboardingCubit>()
                                      .redirectToLoginPage(context);
                            },
                          ),
                        ),
                        if (context
                                .watch<OnboardingCubit>()
                                .state
                                .currentIndex <
                            pages.length - 1)
                          TextButton(
                              onPressed: () {
                                context
                                    .read<OnboardingCubit>()
                                    .redirectToLoginPage(context);
                              },
                              child: Text(
                                translations.skip,
                                style: context.theme.textTheme.bodySmall!
                                    .copyWith(
                                        color: const Color.fromRGBO(
                                            158, 158, 158, 1)),
                              ))
                      ]),
                )
              ],
            );
          },
        )),
      ),
    );
  }
}
