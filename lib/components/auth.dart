import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:passtrack/pages/sign.dart';
import 'package:passtrack/pages/home.dart';

class AuthService {
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  Widget handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return const HomePage();
        } else {
          return const SignInUp();
        }
      },
    );
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: <String>["email"]).signIn();

      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print("Error signing in with Google: ${e.code}");
      return null;
    } catch (e) {
      print("Error signing in: $e");
      return null;
    }
  }
}