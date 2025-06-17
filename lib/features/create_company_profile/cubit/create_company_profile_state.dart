part of 'create_company_profile_cubit.dart';

sealed class CreateCompanyProfileState {}

final class CreateCompanyProfileInitial extends CreateCompanyProfileState {}

final class StepChanged extends CreateCompanyProfileState {}

final class CompanyDataChanged extends CreateCompanyProfileState {}
