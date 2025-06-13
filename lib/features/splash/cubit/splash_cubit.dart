import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  // final UserRepository userRepo;
  //late Person currentUser;
  //SplashCubit(this.userRepo) : super(SplashInitial());
  SplashCubit() : super(SplashInitial());

  // Future<void> refreshUserData(BuildContext context) async {
  //   // try {
  //   //   await checkForApPUpdate();
  //   //   bool isFirstTime = Prefs.getBool(SPKeys.isFirstTime) ?? true;
  //   //   bool isLoggedIn = Prefs.getBool(SPKeys.isLoggedIn) ?? false;

  //   //   if (isFirstTime) {
  //   //     Prefs.setBool(SPKeys.isFirstTime, false);
  //   //     GoRouter.of(context).goNamed(RoutingManager.onboardingScreen);
  //   //     return;
  //   //   }
  //   //   if (!isLoggedIn) {
  //   //     GoRouter.of(context).goNamed(RoutingManager.loginScreen);
  //   //     return;
  //   //   }
  //   //   currentUser = await userRepo.getCurrentUserData();
  //   //   await Person.updatePersonData(currentUser);
  //   //   redirect(context, currentUser);
  //   // } on UnAuthenticatedException catch (e) {
  //   //   GlobalExceptionHandler.handle(exception: e);
  //   //   await GoRouter.of(context).pushReplacement(RoutingManager.loginScreen);
  //   // } catch (e) {
  //   //   GlobalExceptionHandler.handle(exception: e);
  //   //   await GoRouter.of(context).pushReplacement(RoutingManager.loginScreen);
  //   // }
  // }

  // void redirect()
  //   //BuildContext context, Person person)
  //    async {
  //   // if (!person.user!.isActive) {
  //   //   throw AccountNotActiveException(message: localization.accountDisabled);
  //   // }
  //   GoRouter.of(context).goNamed(RoutingManager.appLayoutScreen);
  // }

//   Future<void> checkForApPUpdate() async {
//  //   await AppUpdater.checkForUpdates();
//   }
}
