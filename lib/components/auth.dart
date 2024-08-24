import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:passtrack/pages/sign.dart';
import 'package:passtrack/pages/home.dart';
import 'package:logger/logger.dart';
import 'dart:async';

class AuthService {
  final logger = Logger();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Widget handleAuthState() {
    return StreamBuilder(
      stream: _auth.authStateChanges(),
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
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: <String>["email"]).signIn();

      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      logger.d("Error signing in with Google: ${e.code}");
      return null;
    } catch (e) {
      logger.d("Error signing in: $e");
      return null;
    }
  }

  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      logger.d("Error signing in with email: ${e.code}");
      return null;
    }
  }

  Future<UserCredential?> createUserWithEmail(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      
      return userCredential;


    } on FirebaseAuthException catch (e) {
      logger.d("Error creating user with email: ${e.code}");
      return null;
    }
  }

  Future<UserCredential?> signInWithPhone(String phoneNumber) async {
    Completer<UserCredential?> completer = Completer();

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          UserCredential userCredential =
              await _auth.signInWithCredential(credential);
          completer.complete(userCredential);
        } catch (e) {
          logger.d("Error in verificationCompleted: $e");
          completer.complete(null);
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        logger.d("Phone verification failed: ${e.code}");
        completer.complete(null);
      },
      codeSent: (String verificationId, int? resendToken) {
        // Here, you would typically show a UI for the user to enter the SMS code
        // For now, we'll just complete with null
        logger.d("SMS code sent. Verification ID: $verificationId");
        // Don't complete the completer here, wait for manual code entry
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        logger.d("Auto retrieval timeout. Verification ID: $verificationId");
        // Don't complete the completer here, it might have been completed already
      },
    );

    return completer.future;
  }
}
