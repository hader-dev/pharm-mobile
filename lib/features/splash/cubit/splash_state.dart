part of 'splash_cubit.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class SplashCompleted extends SplashState {}

final class SplashRedirectedToLogin extends SplashState {}

final class SplashFailed extends SplashState {}
