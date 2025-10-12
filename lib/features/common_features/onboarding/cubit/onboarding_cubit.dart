import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/di/di.dart';
import '../../../../config/routes/routing_manager.dart';
import '../../../../utils/shared_prefs.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  int currentIndex = 0;
  int pagesCount = 0;
  PageController pageController = PageController();
  OnboardingCubit() : super(OnboardingInitial());

  void initPagesCount(int pages) {
    pagesCount = pages;
    emit(OnboardingInitial());
  }

  Future<void> nextPage() async {
    if (currentIndex < pagesCount) {
      currentIndex = currentIndex + 1;
      await pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
    emit(OnboardingPageChanged());
  }

  // void previousPage() async {
  //   currentIndex = currentIndex - 1;
  //   await pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
  // }

  void onPageChanged(int value) {
    currentIndex = value;
    emit(OnboardingComplete());
  }

  void redirectToLoginPage(BuildContext context) async {
    getItInstance.get<SharedPreferences>().setBool(SPKeys.isFirstLoggin, false);
    GoRouter.of(context).pushReplacementNamed(RoutingManager.loginScreen);
  }
}
