class EmailRegisterFormDataModel {
  String email;
  String fullName;
  String password;
  String confirmPassword;

  EmailRegisterFormDataModel(
      {this.fullName = "",
      this.email = "",
      this.password = "",
      this.confirmPassword = ""});

  EmailRegisterFormDataModel copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? fullName,
  }) {
    return EmailRegisterFormDataModel(
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        fullName: fullName ?? this.fullName);
  }

  @override
  String toString() {
    return 'EmailRegisterFormDataModel{email: $email, fullName: $fullName, password: $password, confirmPassword: $confirmPassword}';
  }
}
