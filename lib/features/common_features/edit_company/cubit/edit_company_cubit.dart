import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/edit_company/hooks_data_model/edit_company_form.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/company_repository.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';
import 'package:hader_pharm_mobile/utils/device_gallery_helper.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';

part 'edit_company_state.dart';

class EditCompanyCubit extends Cubit<EditCompanyState> {
  final ICompanyRepository companyRepository;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  EditCompanyCubit({required this.companyRepository})
      : super(EditCompanyInitial());

  Future<void> initCompanyData() async {
    try {
      emit(state.toLoading());

      late Company companyData;

      try {
        companyData = await companyRepository.getMyCompany();
      } catch (e) {
        debugPrint("No company found for user: $e");
        emit(state.toCompanyNotFound());
        return;
      }

      final formData = state.formData.copyWith(
        companyName: companyData.name,
        email: companyData.email,
        phone: companyData.phone,
        phone2: companyData.phone2,
        fax: companyData.fax,
        address: companyData.address,
        website: companyData.website,
        description: companyData.description,
        rcNumber: companyData.rcNumber,
        nisNumber: companyData.nisNumber,
        aiNumber: companyData.aiNumber,
        fiscalId: companyData.fiscalId,
        bankAccount: companyData.bankAccount,
      );

      emit(state.toInitial(
          formData: formData,
          originalFormData: formData,
          company: companyData));
    } catch (e) {
      debugPrint("Error loading company data: $e");
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toEditFailed());
    }
  }

  Future<void> updateCompany(EditCompanyFormDataModel updatedFormData,
      AppLocalizations translation) async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }

      if (!hasChangesComparedTo(updatedFormData)) {
        debugPrint("Company update: No changes detected, skipping API call");

        getItInstance.get<ToastManager>().showToast(
              message: translation.feedback_no_changes_to_update,
              type: ToastType.error,
            );

        emit(state.toEditSuccess(
          formData: updatedFormData,
          originalFormData: updatedFormData,
        ));
        return;
      }

      if (state.pickedImage != null) {
        updatedFormData =
            updatedFormData.copyWith(logoPath: state.pickedImage?.path);
      } else {
        debugPrint("Company update: No image selected");
      }

      await companyRepository.updateMyCompany(
        companyData: updatedFormData,
        shouldRemoveImage: state.shouldRemoveImage,
      );

      await getItInstance.get<UserManager>().getMe();

      await _refreshCompanyData();

      getItInstance.get<ToastManager>().showToast(
          message: translation.feedback_company_updated,
          type: ToastType.success);

      emit(state.toEditSuccess(
          formData: updatedFormData,
          originalFormData: updatedFormData,
          shouldRemoveImage: false,
          resetPickedImage: true));
    } catch (e) {
      debugPrint("Company update error: $e");
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toEditFailed());
    }
  }

  Future<void> pickCompanyLogo() async {
    try {
      final pickedFile = await DeviceGalleryHelper.pickImageFromGallery();
      if (pickedFile != null) {
        emit(state.toImagePicked(
          pickedImage: File(pickedFile.path),
          shouldRemoveImage: false,
        ));
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  void changeFormData({required EditCompanyFormDataModel modifiedData}) {
    emit(state.toEditSuccess(formData: modifiedData));
  }

  bool hasChangesComparedTo(EditCompanyFormDataModel newFormData) {
    bool imageChanged = state.pickedImage != null || state.shouldRemoveImage;

    bool formDataChanged =
        state.originalFormData.companyName != newFormData.companyName ||
            state.originalFormData.email != newFormData.email ||
            state.originalFormData.phone != newFormData.phone ||
            state.originalFormData.phone2 != newFormData.phone2 ||
            state.originalFormData.fax != newFormData.fax ||
            state.originalFormData.address != newFormData.address ||
            state.originalFormData.website != newFormData.website ||
            state.originalFormData.description != newFormData.description ||
            state.originalFormData.rcNumber != newFormData.rcNumber ||
            state.originalFormData.nisNumber != newFormData.nisNumber ||
            state.originalFormData.aiNumber != newFormData.aiNumber ||
            state.originalFormData.fiscalId != newFormData.fiscalId ||
            state.originalFormData.bankAccount != newFormData.bankAccount;

    return imageChanged || formDataChanged;
  }

  void removeImage() {
    emit(state.toImagePicked(
      pickedImage: null,
      shouldRemoveImage: true,
    ));
  }

  Future<void> _refreshCompanyData() async {
    try {
      final companyData = await companyRepository.getMyCompany();

      final formData = state.formData.copyWith(
        companyName: companyData.name,
        email: companyData.email,
        phone: companyData.phone,
        phone2: companyData.phone2,
        fax: companyData.fax,
        address: companyData.address,
        website: companyData.website,
        description: companyData.description,
        rcNumber: companyData.rcNumber,
        nisNumber: companyData.nisNumber,
        aiNumber: companyData.aiNumber,
        fiscalId: companyData.fiscalId,
        bankAccount: companyData.bankAccount,
      );

      final originalFormData = formData;

      emit(state.toInitial(
          formData: formData,
          originalFormData: originalFormData,
          company: companyData));
    } catch (e) {
      debugPrint("Error refreshing company data: $e");
    }
  }
}
