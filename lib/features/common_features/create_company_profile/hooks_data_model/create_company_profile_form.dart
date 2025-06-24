//-----------------------------------
import 'package:hader_pharm_mobile/utils/enums.dart';

class CreateCompanyProfileFormDataModel {
  // Step 1: Company Type
  final int companyType;

  // Step 2: General Information
  final String companyName;
  final String email;
  final String phone;
  final String fax;
  final String fullAddress;
  final String website;

  //only for distributor
  final int? distributorCategoryId;

  // Step 3: Legal Information

  //common btw distributor and pharmacy

  final String nis;
  final String rc;
  final String ai;

  //this field only for distributor
  final String bankAccount;
  final String fiscalId;

  // Step 4: Company Profile
  final String? logoPath;
  final String description;
  final bool isActive = true;

  CreateCompanyProfileFormDataModel({
    this.companyType = 0,
    this.companyName = '',
    this.fullAddress = '',
    this.website = '',
    this.nis = '',
    this.ai = '',
    this.logoPath,
    this.description = '',
    this.email = '',
    this.phone = '',
    this.fax = '',
    this.rc = '',
    this.bankAccount = '',
    this.fiscalId = '',
    this.distributorCategoryId,
  });

  CreateCompanyProfileFormDataModel copyWith(
      {int? companyType,
      String? companyName,
      int? townId,
      String? fullAddress,
      String? website,
      String? nis,
      String? ai,
      String? logoPath,
      String? description,
      String? email,
      String? phone,
      String? fax,
      String? rc,
      String? fiscalId,
      int? distributorCategoryId,
      String? bankAccount}) {
    return CreateCompanyProfileFormDataModel(
        companyType: companyType ?? this.companyType,
        companyName: companyName ?? this.companyName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        fax: fax ?? this.fax,
        fullAddress: fullAddress ?? this.fullAddress,
        website: website ?? this.website,
        nis: nis ?? this.nis,
        ai: ai ?? this.ai,
        logoPath: logoPath ?? this.logoPath,
        description: description ?? this.description,
        rc: rc ?? this.rc,
        bankAccount: bankAccount ?? this.bankAccount,
        distributorCategoryId: distributorCategoryId ?? this.distributorCategoryId,
        fiscalId: fiscalId ?? this.fiscalId);
  }

  Map<String, dynamic> toJson() {
    return {
      'type': companyType,
      'name': companyName,
      'email': email,
      'phone': phone,
      'fax': fax,
      'distributorCategory': distributorCategoryId,
      'address': fullAddress,
      'website': website,
      'rcNumber': rc,
      'nisNumber': nis,
      'aiNumber': ai,
      'fiscalId': fiscalId,
      'description': description,
      'bankAccount': bankAccount,
    };
  }

  @override
  String toString() {
    return 'CreateCompanyProfileFormDataModel{companyType: $companyType, distributorCategoryId: $distributorCategoryId, companyName: $companyName, email: $email, phone: $phone, fullAddress: $fullAddress, website: $website, nis: $nis, ai: $ai, logoPath: $logoPath, description: $description}';
  }
}
