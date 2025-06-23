import 'package:hader_pharm_mobile/utils/assets_strings.dart';

import '../../../config/theme/colors_manager.dart';
import '../../../utils/extensions/app_context_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../utils/constants.dart';

import '../../common/buttons/solid/primary_text_button.dart';
import 'cubit/onboarding_cubit.dart';
import 'widgets/onboarding_page_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = <Widget>[
      Board(
        img: SizedBox(
          child: Image.asset(
            DrawableAssetStrings.board1Img,
            fit: BoxFit.fill,
          ),
        ),
        title: "Find Medicines",
        description:
            "Discover a wide range of medicines and health products with our easy-to-use search feature. Find what you need quickly and efficiently.",
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
        title: "Seamless Shopping Experience",
        description:
            "Easily manage orders and maintain an organized, top-notch service for customers. Enjoy a seamless shopping experience with our user-friendly interface.",
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
          title: "Get Started",
          description:
              "Join Hader Pharma today and enjoy convenient access to pharmaceutical products across different locations. Start now!"),
    ];

    return BlocProvider(
      create: (BuildContext context) => OnboardingCubit()..initPagesCount(pages.length),
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
                        context.read<OnboardingCubit>().onPageChanged(value);
                      },
                      physics: const BouncingScrollPhysics(),
                      controller: context.read<OnboardingCubit>().pageController,
                      children: pages),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSizesManager.p16),
                  child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppSizesManager.p8),
                      child: SmoothPageIndicator(
                        controller: context.read<OnboardingCubit>().pageController,
                        effect: WormEffect(
                            dotHeight: 5,
                            dotWidth: 15,
                            activeDotColor: context.theme.primaryColor,
                            dotColor: context.theme.primaryColor.withOpacity(.2)),
                        count: pages.length,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: AppSizesManager.p12,
                        left: AppSizesManager.p12,
                        right: AppSizesManager.p12,
                      ),
                      width: double.maxFinite,
                      height: AppSizesManager.buttonHeight,
                      child: PrimaryTextButton(
                        height: AppSizesManager.buttonHeight,
                        label:
                            context.watch<OnboardingCubit>().currentIndex < pages.length - 1 ? 'Continue' : 'Start !',
                        color: context.theme.primaryColor,
                        onTap: () async {
                          context.read<OnboardingCubit>().currentIndex < pages.length - 1
                              ? await context.read<OnboardingCubit>().nextPage()
                              : context.read<OnboardingCubit>().redirectToLoginPage(context);
                        },
                      ),
                    ),
                    if (context.watch<OnboardingCubit>().currentIndex < pages.length - 1)
                      TextButton(
                          onPressed: () {
                            context.read<OnboardingCubit>().redirectToLoginPage(context);
                          },
                          child: Text(
                            'Skip',
                            style: context.theme.textTheme.bodySmall!
                                .copyWith(color: const Color.fromRGBO(158, 158, 158, 1)),
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
