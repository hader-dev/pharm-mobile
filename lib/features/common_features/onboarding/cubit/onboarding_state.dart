part of 'onboarding_cubit.dart';

@immutable
sealed class OnboardingState {
  final int currentIndex;
  final int pagesCount;
  final PageController pageController;

  const OnboardingState(
      {required this.currentIndex,
      required this.pagesCount,
      required this.pageController});

  OnboardingInitial toInitial({required int pagesCount}) =>
      OnboardingInitial.fromState(state: this, pagesCount: pagesCount);

  OnboardingPageChanged toPageChanged(
      {required int currentIndex, required int pagesCount}) {
    return OnboardingPageChanged.fromState(state: this, pagesCount: pagesCount);
  }
}

final class OnboardingInitial extends OnboardingState {
  OnboardingInitial({
    int? currentIndex,
    int? pagesCount,
    PageController? pageController,
  }) : super(
            currentIndex: currentIndex ?? 0,
            pagesCount: pagesCount ?? 0,
            pageController: pageController ?? PageController(initialPage: 0));

  OnboardingInitial.fromState(
      {required OnboardingState state, required super.pagesCount})
      : super(
            currentIndex: state.currentIndex,
            pageController: state.pageController);
}

class OnboardingComplete extends OnboardingState {
  OnboardingComplete.fromState({
    required OnboardingState state,
  }) : super(
          currentIndex: state.currentIndex,
          pagesCount: state.pagesCount,
          pageController: state.pageController,
        );
}

class OnboardingPageChanged extends OnboardingState {
  OnboardingPageChanged.fromState({
    required OnboardingState state,
    required super.pagesCount,
  }) : super(
          currentIndex: state.currentIndex,
          pageController: state.pageController,
        );
}
