import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';

import '../hooks_data_model/create_company_profile_form.dart';

part 'create_company_profile_state.dart';

class CreateCompanyProfileCubit extends Cubit<CreateCompanyProfileState> {
  int currentStepIndex = 0;
  CreateCompanyProfileFormDataModel companyData = CreateCompanyProfileFormDataModel(
    companyType: 0,
    townId: -1,
  );
  final pageController = PageController(initialPage: 0);

  CreateCompanyProfileCubit() : super(CreateCompanyProfileInitial());

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

  changeCompanyData({required CreateCompanyProfileFormDataModel modifiedData}) {
    debugPrint(modifiedData.toString());
    companyData = modifiedData;
    emit(CompanyDataChanged());
  }
}
