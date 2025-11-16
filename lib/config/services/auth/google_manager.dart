import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleManager {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<GoogleSignInAccount?> signIn() async {
    try {
      final res = await _googleSignIn.authenticate(
        scopeHint: ['email', 'profile'],
      );

      return res;
    } catch (e) {
      debugPrintStack(stackTrace: StackTrace.current);
      debugPrint("$e");
      return null;
    }
  }

  bool isSupported() => _googleSignIn.supportsAuthenticate();

  static Future<void> setup() async {
    await GoogleSignIn.instance.initialize();
  }
}
