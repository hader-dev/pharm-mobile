part of 'create_company_profile_cubit.dart';

sealed class CreateCompanyProfileState {}

final class CreateCompanyProfileInitial extends CreateCompanyProfileState {}

final class StepChanged extends CreateCompanyProfileState {}

final class CompanyDataChanged extends CreateCompanyProfileState {}

final class ImagePicked extends CreateCompanyProfileState {}

//Company creation states
final class CreatingCompany extends CreateCompanyProfileState {}

final class CompanyCreated extends CreateCompanyProfileState {}

final class CompanyCreationFailed extends CreateCompanyProfileState {}

final class UserImagePicked extends CreateCompanyProfileState {}
