class ResponseOrderCancel {
  final bool success;
  final int statusCode;

  ResponseOrderCancel({this.statusCode = 200, this.success = true});


  factory ResponseOrderCancel.error() => ResponseOrderCancel(success: false,statusCode: 400);
}
