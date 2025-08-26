import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/repositories/locale/privacy_policy/privacy_policy_repository.dart';

part 'state.dart';

class LegalPolicyCubit extends Cubit<LegalPolicyState> {
  final IPrivacyPolicyRepository privacyPolicyRepository;
  final String locale;

  LegalPolicyCubit({required this.privacyPolicyRepository, this.locale = 'fr'})
      : super(LegalPolicyInitial());

  Future<void> getPrivacyPolicy() async {
    try {
      emit(state.loading());
      final privacyPolicy =
          await privacyPolicyRepository.getPrivacyPolicy(locale);
      emit(state.loaded(legalPolicy: privacyPolicy));
    } catch (e) {
      debugPrint("$e");
      emit(state.loadingFailed());
    }
  }
}
