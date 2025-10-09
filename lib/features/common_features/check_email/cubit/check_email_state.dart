part of 'check_email_cubit.dart';

class CheckEmailState {
  final String userEmail;
  final bool isResendActive;

  CheckEmailState({required this.userEmail, required this.isResendActive});

  CheckEmailState copyWith({
    String? userEmail,
    bool? isResendActive,
  }) =>
      CheckEmailState(
        userEmail: userEmail ?? this.userEmail,
        isResendActive: isResendActive ?? this.isResendActive,
      );

  CheckEmailInitial initial({
    String? userEmail,
    bool? isResendActive,
  }) =>
      CheckEmailInitial.fromState(
          state: this, userEmail: userEmail, isResendActive: isResendActive);

  CheckEmailLoading loading() => CheckEmailLoading.fromState(this);
  CheckEmailSuccess success() => CheckEmailSuccess.fromState(this);
  CheckEmailFailed failed() => CheckEmailFailed.fromState(this);
  InitEmail initEmail({required String email}) =>
      InitEmail.fromState(state: this, email: email);

  TimerCountChanged counterTicked(
          {required int count, required bool isResendActive}) =>
      TimerCountChanged.fromState(
          state: this, count: count, isResendActive: isResendActive);
}

final class CheckEmailInitial extends CheckEmailState {
  CheckEmailInitial({String? userEmail, bool? isResendActive})
      : super(
            userEmail: userEmail ?? "", isResendActive: isResendActive ?? true);

  factory CheckEmailInitial.fromState(
          {required CheckEmailState state,
          String? userEmail,
          bool? isResendActive}) =>
      CheckEmailInitial(
        userEmail: userEmail ?? state.userEmail,
        isResendActive: isResendActive ?? state.isResendActive,
      );
}

final class CheckEmailLoading extends CheckEmailInitial {
  CheckEmailLoading({super.userEmail, super.isResendActive});

  factory CheckEmailLoading.fromState(CheckEmailState state) =>
      CheckEmailLoading(
        userEmail: state.userEmail,
        isResendActive: state.isResendActive,
      );
}

final class CheckEmailSuccess extends CheckEmailInitial {
  CheckEmailSuccess({super.userEmail, super.isResendActive});

  factory CheckEmailSuccess.fromState(CheckEmailState state) =>
      CheckEmailSuccess(
        userEmail: state.userEmail,
        isResendActive: state.isResendActive,
      );
}

final class CheckEmailFailed extends CheckEmailInitial {
  CheckEmailFailed({super.userEmail, super.isResendActive});

  factory CheckEmailFailed.fromState(CheckEmailState state) => CheckEmailFailed(
        userEmail: state.userEmail,
        isResendActive: state.isResendActive,
      );
}

final class InitEmail extends CheckEmailInitial {
  InitEmail({super.userEmail, super.isResendActive});

  factory InitEmail.fromState(
          {required CheckEmailState state, String? email}) =>
      InitEmail(
        userEmail: email ?? state.userEmail,
        isResendActive: state.isResendActive,
      );
}

final class ResendOtpLoading extends CheckEmailInitial {
  ResendOtpLoading({super.userEmail, super.isResendActive});

  factory ResendOtpLoading.fromState(CheckEmailState state) => ResendOtpLoading(
        userEmail: state.userEmail,
        isResendActive: state.isResendActive,
      );
}

final class TimerCountChanged extends CheckEmailInitial {
  final int count;
  TimerCountChanged(
      {required this.count, super.userEmail, super.isResendActive});

  factory TimerCountChanged.fromState(
          {required CheckEmailState state,
          required int count,
          required bool isResendActive}) =>
      TimerCountChanged(
        count: count,
        userEmail: state.userEmail,
        isResendActive: isResendActive,
      );
}
