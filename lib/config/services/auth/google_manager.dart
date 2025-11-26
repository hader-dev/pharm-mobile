import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class GoogleManager {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<String?> signIn() async {
    try {
      final res = await _googleSignIn.authenticate(
        scopeHint: ['email', 'profile'],
      );

      final credential = GoogleAuthProvider.credential(
        idToken: res.authentication.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      final firebaseToken = await userCredential.user!.getIdToken(true);

      return firebaseToken;
    } catch (e) {
      throw RoutingManager.rootNavigatorKey.currentContext!.translation!.failed_google_signin;
    }
  }

  bool isSupported() => _googleSignIn.supportsAuthenticate();

  static Future<void> setup() async {
    await GoogleSignIn.instance.initialize();
  }
}
