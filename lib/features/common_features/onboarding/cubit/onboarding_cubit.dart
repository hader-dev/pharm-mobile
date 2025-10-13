import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/utils/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  void initPagesCount(int pages) {
    emit(state.toInitial(pagesCount: pages));
  }

  Future<void> nextPage() async {
    int currentIndex = state.currentIndex;

    if (state.currentIndex < state.pagesCount) {
      currentIndex = currentIndex + 1;
      await state.pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
    emit(state.toPageChanged(
      currentIndex: currentIndex + 1,
      pagesCount: state.pagesCount,
    ));
  }

  void onPageChanged(int value) {
    emit(state.toPageChanged(
      currentIndex: value,
      pagesCount: state.pagesCount,
    ));
  }

  void redirectToLoginPage(BuildContext context) async {
    getItInstance.get<SharedPreferences>().setBool(SPKeys.isFirstLoggin, false);
    GoRouter.of(context).pushReplacementNamed(RoutingManager.loginScreen);
  }
}
