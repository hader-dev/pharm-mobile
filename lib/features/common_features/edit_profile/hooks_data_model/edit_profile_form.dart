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
    String? imagePath,
    String? fullName,
    String? address,
  }) {
    return EditProfileFormDataModel(
        email: email ?? this.email,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        imagePath: imagePath ?? this.imagePath,
        fullName: fullName ?? this.fullName);
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      // Temporarily removing address to test if it's causing the server error
      // 'address': address,
    };
  }

  @override
  String toString() {
    return 'EmailRegisterFormDataModel{email: $email, fullName: $fullName, phone: $phone, imagePath: $imagePath}';
  }
}
