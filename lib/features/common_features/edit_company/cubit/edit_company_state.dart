part of 'edit_company_cubit.dart';

sealed class EditCompanyState {
  final Company companyData;
  final EditCompanyFormDataModel? originalFormData;
  final EditCompanyFormDataModel formData;
  final File? pickedImage;
  final bool shouldRemoveImage;

  EditCompanyState(
      {required this.companyData,
      required this.originalFormData,
      required this.formData,
      required this.pickedImage,
      required this.shouldRemoveImage});

  EditCompanyLoading toLoading() => EditCompanyLoading.fromState(state: this);

  EditCompanyState toCompanyNotFound() => EditCompanyNoCompanyFound.fromState(
        state: this,
      );

  EditCompanyFailed toEditFailed() => EditCompanyFailed.fromState(state: this);

  EditCompanyState toEditSuccess(
          {required EditCompanyFormDataModel formData,
          EditCompanyFormDataModel? originalFormData,
          bool? shouldRemoveImage,
          bool resetPickedImage = false}) =>
      EditCompanySuccess.fromState(
          state: this,
          formData: formData,
          shouldRemoveImage: shouldRemoveImage,
          resetPickedImage: resetPickedImage);

  CompanyImagePicked toImagePicked(
          {File? pickedImage, required bool shouldRemoveImage}) =>
      CompanyImagePicked.fromState(
          state: this,
          pickedImage: pickedImage,
          shouldRemoveImage: shouldRemoveImage);

  EditCompanyState toInitial(
          {required EditCompanyFormDataModel formData,
          required Company company,
          required EditCompanyFormDataModel originalFormData}) =>
      EditCompanyInitial(
        formData: formData,
        company: company,
        originalFormData: originalFormData,
      );
}

final class EditCompanyInitial extends EditCompanyState {
  EditCompanyInitial(
      {Company? company,
      super.originalFormData,
      EditCompanyFormDataModel? formData,
      super.pickedImage,
      super.shouldRemoveImage = false})
      : super(
            companyData: company ?? Company.empty(),
            formData: formData ?? EditCompanyFormDataModel());
}

final class EditCompanyLoading extends EditCompanyInitial {
  EditCompanyLoading.fromState({required EditCompanyState state})
      : super(
            company: state.companyData,
            originalFormData: state.originalFormData,
            formData: state.formData,
            pickedImage: state.pickedImage,
            shouldRemoveImage: state.shouldRemoveImage);
}

final class EditCompanySuccess extends EditCompanyInitial {
  EditCompanySuccess.fromState({
    required EditCompanyState state,
    bool? shouldRemoveImage,
    super.formData,
    bool resetPickedImage = false,
  }) : super(
            company: state.companyData,
            originalFormData: formData,
            pickedImage: resetPickedImage ? null : state.pickedImage,
            shouldRemoveImage: shouldRemoveImage ?? state.shouldRemoveImage);
}

final class CompanyDataLoaded extends EditCompanyInitial {
  CompanyDataLoaded.fromState({required EditCompanyState state})
      : super(
            company: state.companyData,
            originalFormData: state.originalFormData,
            formData: state.formData,
            pickedImage: state.pickedImage,
            shouldRemoveImage: state.shouldRemoveImage);
}

final class EditCompanyFailed extends EditCompanyInitial {
  EditCompanyFailed.fromState({required EditCompanyState state})
      : super(
            company: state.companyData,
            originalFormData: state.originalFormData,
            formData: state.formData,
            pickedImage: state.pickedImage,
            shouldRemoveImage: state.shouldRemoveImage);
}

final class CompanyImagePicked extends EditCompanyInitial {
  CompanyImagePicked.fromState(
      {required EditCompanyState state,
      required super.pickedImage,
      required super.shouldRemoveImage})
      : super(
            company: state.companyData,
            originalFormData: state.originalFormData,
            formData: state.formData);
}

final class EditCompanyNoCompanyFound extends EditCompanyInitial {
  EditCompanyNoCompanyFound.fromState({required EditCompanyState state})
      : super(
            company: state.companyData,
            originalFormData: state.originalFormData,
            formData: state.formData,
            pickedImage: state.pickedImage,
            shouldRemoveImage: state.shouldRemoveImage);
}
