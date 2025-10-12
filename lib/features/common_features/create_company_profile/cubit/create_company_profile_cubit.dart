import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/token_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/hooks_data_model/create_company_profile_form.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/company_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';
import 'package:hader_pharm_mobile/utils/device_gallery_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';
import 'package:image_picker/image_picker.dart';

part 'create_company_profile_state.dart';

class CreateCompanyProfileCubit extends Cubit<CreateCompanyProfileState> {
  int currentStepIndex = 0;
  XFile? pickedImage;
  List<GlobalKey<FormState>> formKeys =
      List.generate(2, (_) => GlobalKey<FormState>());
  CreateCompanyProfileFormDataModel companyData =
      CreateCompanyProfileFormDataModel(
    companyType: 0,
  );
  final pageController = PageController(initialPage: 0);
  final CompanyRepository companyRepository;
  CreateCompanyProfileCubit({required this.companyRepository})
      : super(CreateCompanyProfileInitial());

  void validateCompanyData(BuildContext context) async {
    try {
      switch (currentStepIndex) {
        case 0:
          {
            if (companyData.companyType == 0) {
              throw context.translation!.feedback_select_company_type;
            } else {
              nextStep();
            }
          }
        case 1:
          {
            if (!formKeys[0].currentState!.validate()) {
              throw context.translation!.feedback_fill_missing_fields;
            } else {
              nextStep();
            }
          }
        case 2:
          if (!formKeys[1].currentState!.validate()) {
            throw context.translation!.feedback_fill_missing_fields;
          } else {
            nextStep();
          }
        case 3:
          nextStep();
        case 4:
          {
            await createCompany(companyData);
          }
      }
    } catch (e) {
      getItInstance
          .get<ToastManager>()
          .showToast(type: ToastType.warning, message: e.toString());
    }
  }

  void nextStep() {
    if (currentStepIndex == 4) return;
    currentStepIndex++;
    pageController.jumpToPage(currentStepIndex);
    emit(StepChanged());
  }

  void previousStep() {
    if (currentStepIndex == 0) return;
    currentStepIndex--;
    pageController.jumpToPage(currentStepIndex);
    emit(StepChanged());
  }

  void changeCompanyData(
      {required CreateCompanyProfileFormDataModel modifiedData}) {
    debugPrint(modifiedData.toString());
    companyData = modifiedData;
    emit(CompanyDataChanged());
  }

  Future<void> pickGalleryImage() async {
    try {
      pickedImage = await DeviceGalleryHelper.pickImageFromGallery();
      if (pickedImage != null) {
        companyData = companyData.copyWith(logoPath: pickedImage!.path);
        emit(ImagePicked());
      }
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(CompanyCreationFailed());
    }
  }

  Future<void> createCompany(
      CreateCompanyProfileFormDataModel companyData) async {
    try {
      emit(CreatingCompany());

      await companyRepository.createCompany(companyData);
      var client = getItInstance.get<INetworkService>();
      var tokenManger = getItInstance.get<TokenManager>();
      await tokenManger.refreshToken(client);

      await getItInstance.get<UserManager>().getMe();

      emit(CompanyCreated());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(CompanyCreationFailed());
    }
  }

  void removeImage() {
    pickedImage = null;
    emit(UserImagePicked());
  }
}
