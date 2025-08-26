part of 'cubit.dart';

sealed class LegalPolicyState {
  final String legalPolicy;

  const LegalPolicyState({required this.legalPolicy});

  LegalPolicyState initial() => LegalPolicyInitial();
  LegalPolicyState loading() => LegalPolicyLoading();
  LegalPolicyState loaded({required String legalPolicy}) =>
      LegalPolicyLoaded(legalPolicy: legalPolicy);
  LegalPolicyState loadingFailed() => LegalPolicyLoadingFailed();
}

class LegalPolicyInitial extends LegalPolicyState {
  LegalPolicyInitial({super.legalPolicy = ''});
}

class LegalPolicyLoading extends LegalPolicyInitial {}

class LegalPolicyLoaded extends LegalPolicyState {
  LegalPolicyLoaded({required super.legalPolicy});
}

class LegalPolicyLoadingFailed extends LegalPolicyInitial {}
