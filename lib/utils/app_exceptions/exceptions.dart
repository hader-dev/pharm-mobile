class TemplateException implements Exception {
  final String? error;
  final String? message;
  final int? statusCode;
  final String? path;
  final String? errorCode;
  final String? errorType;

  final String? timestamp;

  final List<FieldError>? errors;
  TemplateException(
      {this.message,
      this.statusCode,
      this.error,
      this.errorType,
      this.path,
      this.errorCode,
      this.timestamp,
      this.errors})
      : super();
  factory TemplateException.fromJson(Map<String, dynamic> json) => TemplateException(
        message: json['message'],
        statusCode: json['statusCode'],
        error: json['error'],
        errorType: json['type'],
        path: json['path'],
        timestamp: json['timestamp'],
        errorCode: json['code'],
        errors: json['errors'] == null ? null : (json['errors'] as List).map((e) => FieldError.fromJson(e)).toList(),
      );

  @override
  String toString() {
    return "$message";
  }
}

class InternalServerErrorException extends TemplateException {
  InternalServerErrorException({
    super.message,
    super.statusCode,
    super.error,
    super.errorType,
    super.path,
    super.timestamp,
    super.errors,
    super.errorCode,
  });

  factory InternalServerErrorException.fromJson(Map<String, dynamic> json) => InternalServerErrorException(
        message: json['message'],
        statusCode: json['statusCode'],
        error: json['error'],
        errorType: json['type'],
        path: json['path'],
        timestamp: json['timestamp'],
        errorCode: json['code'],
        errors: json['errors'] == null ? null : (json['errors'] as List).map((e) => FieldError.fromJson(e)).toList(),
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
    super.errorCode,
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
      errors: json['errors'] == null ? null : (json['errors'] as List).map((e) => FieldError.fromJson(e)).toList(),
      meta: json['meta'],
      errorCode: json['code'],
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
      super.errors,
      super.errorCode});
  factory ReachSearchLimitException.fromJson(Map<String, dynamic> json) => ReachSearchLimitException(
        message: json['message'],
        statusCode: json['statusCode'],
        error: json['error'],
        errorType: json['type'],
        path: json['path'],
        timestamp: json['timestamp'],
        errors: json['errors'] == null ? null : (json['errors'] as List).map((e) => FieldError.fromJson(e)).toList(),
        errorCode: json['code'],
      );
}

class BadRequestException extends TemplateException {
  BadRequestException(
      {super.message,
      super.statusCode,
      super.error,
      super.errorType,
      super.path,
      super.errorCode,
      super.timestamp,
      super.errors});
  factory BadRequestException.fromJson(Map<String, dynamic> json) => BadRequestException(
        message: json['message'],
        statusCode: json['statusCode'],
        error: json['error'],
        errorType: json['type'],
        path: json['path'],
        timestamp: json['timestamp'],
        errorCode: json['code'],
        errors: json['errors'] == null ? null : (json['errors'] as List).map((e) => FieldError.fromJson(e)).toList(),
      );
}

class DataValidationException extends TemplateException {
  DataValidationException(
      {super.message,
      super.statusCode,
      super.error,
      super.errorType,
      super.path,
      super.errorCode,
      super.timestamp,
      super.errors});
  factory DataValidationException.fromJson(Map<String, dynamic> json) => DataValidationException(
        message: json['message'],
        statusCode: json['statusCode'],
        error: json['error'],
        errorType: json['type'],
        path: json['path'],
        timestamp: json['timestamp'],
        errorCode: json['code'],
        errors: json['errors'] == null ? null : (json['errors'] as List).map((e) => FieldError.fromJson(e)).toList(),
      );
}

class TooManyRequestsException extends TemplateException {
  TooManyRequestsException(
      {super.message,
      super.statusCode,
      super.error,
      super.errorType,
      super.path,
      super.errorCode,
      super.timestamp,
      super.errors});
  factory TooManyRequestsException.fromJson(Map<String, dynamic> json) => TooManyRequestsException(
        message: json['message'],
        statusCode: json['statusCode'],
        error: json['error'],
        errorType: json['type'],
        path: json['path'],
        timestamp: json['timestamp'],
        errorCode: json['code'],
        errors: json['errors'] == null ? null : (json['errors'] as List).map((e) => FieldError.fromJson(e)).toList(),
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
      super.errors,
      super.errorCode});
  factory AccountNotActiveException.fromJson(Map<String, dynamic> json) => AccountNotActiveException(
        message: json['message'],
        statusCode: json['statusCode'],
        error: json['error'],
        errorType: json['type'],
        path: json['path'],
        timestamp: json['timestamp'],
        errors: json['errors'] == null ? null : (json['errors'] as List).map((e) => FieldError.fromJson(e)).toList(),
        errorCode: json['code'],
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
      super.errors,
      super.errorCode});
  factory FetchDataException.fromJson(Map<String, dynamic> json) => FetchDataException(
        message: json['message'],
        statusCode: json['statusCode'],
        error: json['error'],
        errorType: json['type'],
        path: json['path'],
        timestamp: json['timestamp'],
        errors: json['errors'] == null ? null : (json['errors'] as List).map((e) => FieldError.fromJson(e)).toList(),
        errorCode: json['code'],
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
      super.errors,
      super.errorCode});
  factory UnAuthorizedException.fromJson(Map<String, dynamic> json) => UnAuthorizedException(
        message: json['message'],
        statusCode: json['statusCode'],
        error: json['error'],
        errorType: json['type'],
        path: json['path'],
        timestamp: json['timestamp'],
        errors: json['errors'] == null ? null : (json['errors'] as List).map((e) => FieldError.fromJson(e)).toList(),
        errorCode: json['code'],
      );
}

class EmailNotVerifiedException extends TemplateException {
  EmailNotVerifiedException(
      {super.message,
      super.statusCode,
      super.error,
      super.errorType,
      super.path,
      super.timestamp,
      super.errors,
      super.errorCode});
  factory EmailNotVerifiedException.fromJson(Map<String, dynamic> json) => EmailNotVerifiedException(
        message: json['message'],
        statusCode: json['statusCode'],
        error: json['error'],
        errorType: json['type'],
        path: json['path'],
        timestamp: json['timestamp'],
        errors: json['errors'] == null ? null : (json['errors'] as List).map((e) => FieldError.fromJson(e)).toList(),
        errorCode: json['code'],
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
      super.errors,
      super.errorCode});
  factory UnAuthenticatedException.fromJson(Map<String, dynamic> json) => UnAuthenticatedException(
        message: json['message'],
        statusCode: json['statusCode'],
        error: json['error'],
        errorType: json['type'],
        path: json['path'],
        timestamp: json['timestamp'],
        errors: json['errors'] == null ? null : (json['errors'] as List).map((e) => FieldError.fromJson(e)).toList(),
        errorCode: json['code'],
      );
}

class NotFoundException extends TemplateException {
  NotFoundException({
    super.message,
    super.statusCode,
    super.error,
    super.errorType,
    super.path,
    super.timestamp,
    super.errors,
    super.errorCode,
  });

  factory NotFoundException.fromJson(Map<String, dynamic> json) {
    return NotFoundException(
      message: json['message'],
      statusCode: json['statusCode'],
      error: json['error'],
      errorType: json['type'],
      path: json['path'],
      timestamp: json['timestamp'],
      errors: json['errors'] == null ? null : (json['errors'] as List).map((e) => FieldError.fromJson(e)).toList(),
      errorCode: json['code'],
    );
  }
}


class ConstraintFailedException extends TemplateException {
  ConstraintFailedException({
    super.message,
    super.statusCode,
    super.error,
    super.errorType,
    super.path,
    super.timestamp,
    super.errors,
    super.errorCode,
  });

  factory ConstraintFailedException.fromJson(Map<String, dynamic> json) {
    return ConstraintFailedException(
      message: json['message'],
      statusCode: json['statusCode'],
      error: json['error'],
      errorType: json['type'],
      path: json['path'],
      timestamp: json['timestamp'],
      errors: json['errors'] == null ? null : (json['errors'] as List).map((e) => FieldError.fromJson(e)).toList(),
      errorCode: json['code'],
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
  String toString() => '$field: ($message)';
}
