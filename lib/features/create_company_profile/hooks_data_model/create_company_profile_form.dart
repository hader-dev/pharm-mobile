//-----------------------------------
class CreateCompanyProfileFormDataModel {
  // Step 1: Company Type
  final int companyType;

  // Step 2: General Information
  final String companyName;

  final int townId;
  final String fullAddress;
  final String website;

  // Step 3: Legal Information
  final String nif;
  final String nis;
  final String commercialRegNumber;
  final String creditLimit;

  final String ai;

  // Step 4: Company Profile
  final String? logoPath; // e.g. path or network URL
  final String description;

  CreateCompanyProfileFormDataModel({
    this.companyType = 0,
    this.companyName = '',
    required this.townId,
    this.fullAddress = '',
    this.website = '',
    this.nif = '',
    this.nis = '',
    this.commercialRegNumber = '',
    this.ai = '',
    this.creditLimit = '',
    this.logoPath = '',
    this.description = '',
  });

  CreateCompanyProfileFormDataModel copyWith({
    int? companyType,
    String? companyName,
    int? townId,
    String? fullAddress,
    String? website,
    String? nif,
    String? nis,
    String? commercialRegNumber,
    String? creditLimit,
    String? ai,
    String? logoPath,
    String? description,
  }) {
    return CreateCompanyProfileFormDataModel(
      companyType: companyType ?? this.companyType,
      companyName: companyName ?? this.companyName,
      townId: townId ?? this.townId,
      fullAddress: fullAddress ?? this.fullAddress,
      website: website ?? this.website,
      nif: nif ?? this.nif,
      nis: nis ?? this.nis,
      commercialRegNumber: commercialRegNumber ?? this.commercialRegNumber,
      creditLimit: creditLimit ?? this.creditLimit,
      ai: ai ?? this.ai,
      logoPath: logoPath ?? this.logoPath,
      description: description ?? this.description,
    );
  }

  @override
  String toString() {
    return 'CreateCompanyProfileFormDataModel{companyType: $companyType, companyName: $companyName, townId: $townId, fullAddress: $fullAddress, website: $website, nif: $nif, nis: $nis, commercialRegNumber: $commercialRegNumber, creditLimit1: $creditLimit, ai: $ai, logoPath: $logoPath, description: $description}';
  }
}
