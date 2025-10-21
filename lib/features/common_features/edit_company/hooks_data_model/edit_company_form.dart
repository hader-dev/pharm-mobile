class EditCompanyFormDataModel {
  final String companyName;
  final String email;
  final String phone;
  final String? phone2;
  final String? fax;
  final String address;
  final String? website;
  final String description;
  final String? logoPath;
  final String? rcNumber;
  final String? nisNumber;
  final String? aiNumber;
  final String? fiscalId;
  final String? bankAccount;

  EditCompanyFormDataModel({
    this.companyName = "",
    this.email = "",
    this.phone = "",
    this.phone2,
    this.fax,
    this.address = "",
    this.website,
    this.description = "",
    this.logoPath,
    this.rcNumber,
    this.nisNumber,
    this.aiNumber,
    this.fiscalId,
    this.bankAccount,
  });

  EditCompanyFormDataModel copyWith({
    String? companyName,
    String? email,
    String? phone,
    String? phone2,
    String? fax,
    String? address,
    String? website,
    String? description,
    String? logoPath,
    String? rcNumber,
    String? nisNumber,
    String? aiNumber,
    String? fiscalId,
    String? bankAccount,
  }) {
    return EditCompanyFormDataModel(
      companyName: companyName ?? this.companyName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      phone2: phone2 ?? this.phone2,
      fax: fax ?? this.fax,
      address: address ?? this.address,
      website: website ?? this.website,
      description: description ?? this.description,
      logoPath: logoPath ?? this.logoPath,
      rcNumber: rcNumber ?? this.rcNumber,
      nisNumber: nisNumber ?? this.nisNumber,
      aiNumber: aiNumber ?? this.aiNumber,
      fiscalId: fiscalId ?? this.fiscalId,
      bankAccount: bankAccount ?? this.bankAccount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': companyName,
      'email': email,
      'phone': phone,
      if (phone2 != null && phone2!.isNotEmpty) 'phone2': phone2,
      if (fax != null && fax!.isNotEmpty) 'fax': fax,
      'address': address,
      if (website != null && website!.isNotEmpty) 'website': website,
      'description': description,
      if (rcNumber != null && rcNumber!.isNotEmpty) 'rcNumber': rcNumber,
      if (nisNumber != null && nisNumber!.isNotEmpty) 'nisNumber': nisNumber,
      if (aiNumber != null && aiNumber!.isNotEmpty) 'aiNumber': aiNumber,
      if (fiscalId != null && fiscalId!.isNotEmpty) 'fiscalId': fiscalId,
      if (bankAccount != null && bankAccount!.isNotEmpty)
        'bankAccount': bankAccount,
    };
  }

  @override
  String toString() {
    return 'EditCompanyFormDataModel{companyName: $companyName, email: $email, phone: $phone, address: $address, description: $description}';
  }
}
