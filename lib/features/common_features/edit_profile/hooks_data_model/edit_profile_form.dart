class EditProfileFormDataModel {
  String email;
  String fullName;
  String phone;
  final String? imagePath;
  String address;

  EditProfileFormDataModel(
      {this.address = "",
      this.fullName = "",
      this.email = "",
      this.phone = "",
      this.imagePath});

  EditProfileFormDataModel copyWith({
    String? email,
    String? phone,
    String? iamgePath,
    String? fullName,
    String? address,
  }) {
    return EditProfileFormDataModel(
        email: email ?? this.email,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        imagePath: iamgePath ?? imagePath,
        fullName: fullName ?? this.fullName);
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }

  @override
  String toString() {
    return 'EmailRegisterFormDataModel{email: $email, fullName: $fullName, phone: $phone, imagePath: $imagePath}';
  }
}
