import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/company_repository.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';
import 'package:hader_pharm_mobile/utils/device_gallery_helper.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';

import '../hooks_data_model/edit_company_form.dart';

part 'edit_company_state.dart';

class EditCompanyCubit extends Cubit<EditCompanyState> {
  final ICompanyRepository companyRepository;
  
  Company? companyData;
  EditCompanyFormDataModel? originalFormData; // Store original data for comparison
  EditCompanyFormDataModel formData = EditCompanyFormDataModel(); // Current form data
  File? pickedImage;
  bool shouldRemoveImage = false;

  EditCompanyCubit({required this.companyRepository}) : super(EditCompanyInitial());

  Future<void> initCompanyData() async {
    try {
      emit(EditCompanyLoading());

      // Get current company data
      try {
        companyData = await companyRepository.getMyCompany();
      } catch (e) {
        // If user doesn't have a company, emit specific state for no company
        debugPrint("No company found for user: $e");
        emit(EditCompanyNoCompanyFound());
        return;
      }
      
      // Initialize form data with current company data
      formData = formData.copyWith(
        companyName: companyData?.name ?? '',
        email: companyData?.email ?? '',
        phone: companyData?.phone ?? '',
        phone2: companyData?.phone2,
        fax: companyData?.fax,
        address: companyData?.address ?? '',
        website: companyData?.website,
        description: companyData?.description ?? '',
        rcNumber: companyData?.rcNumber,
        nisNumber: companyData?.nisNumber,
        aiNumber: companyData?.aiNumber,
        fiscalId: companyData?.fiscalId,
        bankAccount: companyData?.bankAccount,
      );

      // Store original data for comparison
      originalFormData = formData;
      
      emit(EditCompanySuccess());
    } catch (e) {
      debugPrint("Error loading company data: $e");
      GlobalExceptionHandler.handle(exception: e);
      emit(EditCompanyFailed());
    }
  }

  Future<void> updateCompany(EditCompanyFormDataModel updatedFormData, AppLocalizations translation) async {
    try {
      emit(EditCompanyLoading());

      // Check if any changes were made BEFORE updating formData
      if (!hasChangesComparedTo(updatedFormData)) {
        debugPrint("Company update: No changes detected, skipping API call");
        
        getItInstance
            .get<ToastManager>()
            .showToast(
              message: translation.feedback_no_changes_to_update,
              type: ToastType.info,
            );
        
        emit(EditCompanySuccess());
        return;
      }

      debugPrint("Company update: Changes detected, proceeding with update");
      
      // Update current form data after confirming there are changes
      formData = updatedFormData;

      if (pickedImage != null) {
        debugPrint("Company update: Image selected - ${pickedImage?.path}");
        updatedFormData = updatedFormData.copyWith(logoPath: pickedImage?.path);
      } else {
        debugPrint("Company update: No image selected");
      }

      debugPrint("Company update: Form data - ${updatedFormData.toString()}");

      await companyRepository.updateMyCompany(
        companyData: updatedFormData,
        shouldRemoveImage: shouldRemoveImage,
      );

     
      await getItInstance.get<UserManager>().getMe();
      
     
      await _refreshCompanyData();

      
      shouldRemoveImage = false;
      pickedImage = null;
      
      
      originalFormData = updatedFormData;

      getItInstance
          .get<ToastManager>()
          .showToast(message: translation.feedback_company_updated, type: ToastType.success);

      emit(EditCompanySuccess());
    } catch (e) {
      debugPrint("Company update error: $e");
      GlobalExceptionHandler.handle(exception: e);
      emit(EditCompanyFailed());
    }
  }

  Future<void> pickCompanyLogo() async {
    try {
      final pickedFile = await DeviceGalleryHelper.pickImageFromGallery();
      if (pickedFile != null) {
        pickedImage = File(pickedFile.path);
        shouldRemoveImage = false; 
        emit(CompanyImagePicked());
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  void changeFormData({required EditCompanyFormDataModel modifiedData}) {
    debugPrint(modifiedData.toString());
    formData = modifiedData;
    emit(CompanyDataLoaded());
  }

  
  bool hasChanges() {
    if (originalFormData == null) return false;
    
   
    bool imageChanged = pickedImage != null || shouldRemoveImage;
    
    
    bool formDataChanged = originalFormData!.companyName != formData.companyName ||
        originalFormData!.email != formData.email ||
        originalFormData!.phone != formData.phone ||
        originalFormData!.phone2 != formData.phone2 ||
        originalFormData!.fax != formData.fax ||
        originalFormData!.address != formData.address ||
        originalFormData!.website != formData.website ||
        originalFormData!.description != formData.description ||
        originalFormData!.rcNumber != formData.rcNumber ||
        originalFormData!.nisNumber != formData.nisNumber ||
        originalFormData!.aiNumber != formData.aiNumber ||
        originalFormData!.fiscalId != formData.fiscalId ||
        originalFormData!.bankAccount != formData.bankAccount;
    
    return imageChanged || formDataChanged;
  }

  bool hasChangesComparedTo(EditCompanyFormDataModel newFormData) {
    if (originalFormData == null) return false;
    
    
    bool imageChanged = pickedImage != null || shouldRemoveImage;
    
    
    bool formDataChanged = originalFormData!.companyName != newFormData.companyName ||
        originalFormData!.email != newFormData.email ||
        originalFormData!.phone != newFormData.phone ||
        originalFormData!.phone2 != newFormData.phone2 ||
        originalFormData!.fax != newFormData.fax ||
        originalFormData!.address != newFormData.address ||
        originalFormData!.website != newFormData.website ||
        originalFormData!.description != newFormData.description ||
        originalFormData!.rcNumber != newFormData.rcNumber ||
        originalFormData!.nisNumber != newFormData.nisNumber ||
        originalFormData!.aiNumber != newFormData.aiNumber ||
        originalFormData!.fiscalId != newFormData.fiscalId ||
        originalFormData!.bankAccount != newFormData.bankAccount;
    
    return imageChanged || formDataChanged;
  }

  void removeImage() {
    pickedImage = null;
    shouldRemoveImage = true; 
    emit(CompanyImagePicked());
  }

 
  Future<void> _refreshCompanyData() async {
    try {
      
      companyData = await companyRepository.getMyCompany();
      
      
      formData = formData.copyWith(
        companyName: companyData?.name ?? '',
        email: companyData?.email ?? '',
        phone: companyData?.phone ?? '',
        phone2: companyData?.phone2,
        fax: companyData?.fax,
        address: companyData?.address ?? '',
        website: companyData?.website,
        description: companyData?.description ?? '',
        rcNumber: companyData?.rcNumber,
        nisNumber: companyData?.nisNumber,
        aiNumber: companyData?.aiNumber,
        fiscalId: companyData?.fiscalId,
        bankAccount: companyData?.bankAccount,
      );

      
      originalFormData = formData;
    } catch (e) {
      debugPrint("Error refreshing company data: $e");
      
    }
  }
}
