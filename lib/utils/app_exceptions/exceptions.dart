class TemplateException implements Exception {
  String? message;
  String? error;
  int? statusCode;
  String? errorType;
  String? path;
  String? timestamp;
  List<Map<String, dynamic>>? errors;

  TemplateException(
      {this.message,
      this.statusCode,
      this.error,
      this.errorType,
      this.path,
      this.timestamp,
      this.errors})
      : super();
  factory TemplateException.fromJson(Map<String, dynamic> json) =>
      TemplateException(
        message: json['message'],
        statusCode: json['statusCode'],
        error: json['error'],
        errorType: json['type'],
        path: json['path'],
        timestamp: json['timestamp'],
        errors: json['errors'],
      );

  @override
  String toString() {
    return "$message";
  }
}

class InternalServerErrorException extends TemplateException {
  InternalServerErrorException(
      {super.message,
      super.statusCode,
      super.error,
      super.errorType,
      super.path,
      super.timestamp,
      super.errors});

  factory InternalServerErrorException.fromJson(Map<String, dynamic> json) =>
      InternalServerErrorException(
        message: json['message'],
        statusCode: json['statusCode'],
        error: json['error'],
        errorType: json['type'],
        path: json['path'],
        timestamp: json['timestamp'],
        errors: json['errors'],
      );
}

class InvalidFileTypeException extends TemplateException {
  final Map<String, dynamic>? meta;

  InvalidFileTypeException({
    super.message,
    super.statusCode,
    super.error,
    super.errorType,
    super.path,
    super.timestamp,
    super.errors,
    this.meta,
  });

  factory InvalidFileTypeException.fromJson(Map<String, dynamic> json) {
    return InvalidFileTypeException(
      message: json['message'],
      statusCode: json['statusCode'],
      error: json['error'],
      errorType: json['type'],
      path: json['path'],
      timestamp: json['timestamp'],
      errors: json['errors'],
      meta: json['meta'],
    );
  }
}

class ReachSearchLimitException extends TemplateException {
  ReachSearchLimitException(
      {super.message,
      super.statusCode,
      super.error,
      super.errorType,
      super.path,
      super.timestamp,
      super.errors});
  factory ReachSearchLimitException.fromJson(Map<String, dynamic> json) =>
      ReachSearchLimitException(
        message: json['message'],
        statusCode: json['statusCode'],
        error: json['error'],
        errorType: json['type'],
        path: json['path'],
        timestamp: json['timestamp'],
        errors: json['errors'],
      );
}

class BadRequestException extends TemplateException {
  BadRequestException(
      {super.message,
      super.statusCode,
      super.error,
      super.errorType,
      super.path,
      super.timestamp,
      super.errors});
  factory BadRequestException.fromJson(Map<String, dynamic> json) =>
      BadRequestException(
        message: json['message'],
        statusCode: json['statusCode'],
        error: json['error'],
        errorType: json['type'],
        path: json['path'],
        timestamp: json['timestamp'],
        errors: json['errors'],
      );
}

class AccountNotActiveException extends TemplateException {
  AccountNotActiveException(
      {super.message,
      super.statusCode,
      super.error,
      super.errorType,
      super.path,
      super.timestamp,
      super.errors});
  factory AccountNotActiveException.fromJson(Map<String, dynamic> json) =>
      AccountNotActiveException(
        message: json['message'],
        statusCode: json['statusCode'],
        error: json['error'],
        errorType: json['type'],
        path: json['path'],
        timestamp: json['timestamp'],
        errors: json['errors'],
      );
}

class FetchDataException extends TemplateException {
  FetchDataException(
      {super.message,
      super.statusCode,
      super.error,
      super.errorType,
      super.path,
      super.timestamp,
      super.errors});
  factory FetchDataException.fromJson(Map<String, dynamic> json) =>
      FetchDataException(
        message: json['message'],
        statusCode: json['statusCode'],
        error: json['error'],
        errorType: json['type'],
        path: json['path'],
        timestamp: json['timestamp'],
        errors: json['errors'],
      );
}

class UnAuthorizedException extends TemplateException {
  UnAuthorizedException(
      {super.message,
      super.statusCode,
      super.error,
      super.errorType,
      super.path,
      super.timestamp,
      super.errors});
  factory UnAuthorizedException.fromJson(Map<String, dynamic> json) =>
      UnAuthorizedException(
        message: json['message'],
        statusCode: json['statusCode'],
        error: json['error'],
        errorType: json['type'],
        path: json['path'],
        timestamp: json['timestamp'],
        errors: json['errors'],
      );
}

class UnAuthenticatedException extends TemplateException {
  UnAuthenticatedException(
      {super.message,
      super.statusCode,
      super.error,
      super.errorType,
      super.path,
      super.timestamp,
      super.errors});
  factory UnAuthenticatedException.fromJson(Map<String, dynamic> json) =>
      UnAuthenticatedException(
        message: json['message'],
        statusCode: json['statusCode'],
        error: json['error'],
        errorType: json['type'],
        path: json['path'],
        timestamp: json['timestamp'],
        errors: json['errors'],
      );
}

class NotFoundException extends TemplateException {
  final List<FieldError>? fieldErrors;

  NotFoundException({
    super.message,
    super.statusCode,
    super.error,
    super.errorType,
    super.path,
    super.timestamp,
    super.errors,
    this.fieldErrors,
  });

  factory NotFoundException.fromJson(Map<String, dynamic> json) {
    final errorsJson = json['errors'] as List<dynamic>?;

    return NotFoundException(
      message: json['message'],
      statusCode: json['statusCode'],
      error: json['error'],
      errorType: json['type'],
      path: json['path'],
      timestamp: json['timestamp'],
      errors: json['errors'],
      fieldErrors: errorsJson?.map((e) => FieldError.fromJson(e)).toList(),
    );
  }
}

class FieldError {
  final String? field;
  final String? message;

  FieldError({this.field, this.message});

  factory FieldError.fromJson(Map<String, dynamic> json) {
    return FieldError(
      field: json['field'],
      message: json['message'],
    );
  }

  @override
  String toString() => '$field: $message';
}
