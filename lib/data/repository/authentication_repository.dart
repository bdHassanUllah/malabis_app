// google_sign_in_repository.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:malabis_app/data/providers/authentication_provider.dart';

class GoogleSignInRepository {
  final GoogleSignInProvider _provider = GoogleSignInProvider();

  Future<UserCredential?> signInWithGoogle() async {
    return await _provider.signInWithGoogle();
  }

  Future<void> signOut() async {
    await _provider.signOut();
  }
}