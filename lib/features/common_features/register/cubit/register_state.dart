part of 'register_cubit.dart';

sealed class RegisterState {
  const RegisterState();
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccuss extends RegisterState {
  final String email;
  const RegisterSuccuss({required this.email});
}

final class RegisterFailed extends RegisterState {}

//Tap chanage state
final class TapChanged extends RegisterState {}

//User Image Picked
final class UserImagePicked extends RegisterState {}
