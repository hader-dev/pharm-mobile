import 'package:bloc/bloc.dart';

import '../../../config/services/auth/user_manager.dart';
import '../hooks_data_model/register_email_form.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  int selectedTapIndex = 0;
  final UserManager userManager;
  RegisterCubit({required this.userManager}) : super(RegisterInitial());

  void emailRegister(EmailRegisterFormDataModel formData) async {
    try {
      emit(RegisterLoading());
      // await userManager.emailSignUp(email: formData.email, fullName: formData.fullName, password: formData.password);
      emit(RegisterSuccuss(email: formData.email));
    } catch (e) {
      emit(RegisterFailed());
    }
  }

  changeTab(int index) {
    selectedTapIndex = index;
    emit(TapChanged());
  }
}
