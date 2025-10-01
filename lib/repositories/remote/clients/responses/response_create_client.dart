class ResponseCreateClient {
  final String id;
  final String password;
  final String email;
  final bool failed;
  ResponseCreateClient(
      {required this.password,
      required this.email,
      required this.id,
      this.failed = false});

  factory ResponseCreateClient.failed() {
    return ResponseCreateClient(
      failed: true,
      password: '',
      email: '',
      id: '',
    );
  }
}
