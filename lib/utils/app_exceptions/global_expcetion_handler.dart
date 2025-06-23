import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';

// import 'package:sentry_flutter/sentry_flutter.dart';

import '../enums.dart';
import 'exceptions.dart';

class GlobalExceptionHandler {
  static void handle({dynamic exception, StackTrace? exceptionStackTrace}) async {
    ToastManager toastManager = getItInstance.get<ToastManager>();
    if (exception is SocketException ||
        exception is TimeoutException ||
        exception is DioException &&
            [
              DioExceptionType.connectionTimeout,
              DioExceptionType.receiveTimeout,
              DioExceptionType.sendTimeout,
              DioExceptionType.connectionError
            ].contains(exception.type)) {
      toastManager.showToast(
        type: ToastType.error,
        message: "Connection problem or timeout. Please check your internet connection.",
      );
    } else if (exception is UnAuthorizedException || exception is UnAuthenticatedException) {
      toastManager.showToast(
        type: ToastType.error,
        message: exception.errorCode != null
            ? ApiErrorCodes.values.firstWhere((e) => e.label == exception.errorCode).errorMessage
            : exception.message,
      );
    } else if (exception is TooManyRequestsException) {
      toastManager.showToast(
        type: ToastType.warning,
        message: exception.message,
      );
    } else if (exception is DataValidationException) {
      toastManager.showToast(
        type: ToastType.error,
        message:
            "${exception.message}\n${exception.errors != null ? exception.errors!.map((e) => e.message).join("\n") : ""}",
      );
    } else {
      toastManager.showToast(
        type: ToastType.error,
        message: (exception as TemplateException).message ?? "An unexpected error occurred. Please try again later.",
      );
    }
  }
}
