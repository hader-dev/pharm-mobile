part of 'edit_company_cubit.dart';

sealed class EditCompanyState {}

final class EditCompanyInitial extends EditCompanyState {}

final class EditCompanyLoading extends EditCompanyState {}

final class EditCompanySuccess extends EditCompanyState {}

final class CompanyDataLoaded extends EditCompanyState {}

final class EditCompanyFailed extends EditCompanyState {}

final class CompanyImagePicked extends EditCompanyState {}

final class EditCompanyNoCompanyFound extends EditCompanyState {}
