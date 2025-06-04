import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

// import 'package:sentry_flutter/sentry_flutter.dart';

import 'exceptions.dart';

class GlobalExceptionHandler {
  static void handle({dynamic exception, StackTrace? exceptionStackTrace}) async {
    if (exception is SocketException || exception is TimeoutException || exception is http.ClientException) {
      // Fluttertoast.showToast(msg: localization.connectionProblem);
    } else if (exception is UnAuthorizedException) {
      Fluttertoast.showToast(
        msg: exception.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.black,
      );
    } else if (exception is UnAuthenticatedException) {
      Fluttertoast.showToast(
        msg: exception.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.black,
      );
    } else if (exception is AccountNotActiveException) {
      Fluttertoast.showToast(
        msg: exception.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.black,
      );
    } else {
      Fluttertoast.showToast(
        msg: exception.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.black,
      );
    }
  }
}
