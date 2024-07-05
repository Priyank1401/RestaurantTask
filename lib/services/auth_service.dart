import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:priyank/constant_methods.dart';

class AuthService {

  Future<String?> registration({context, required String email, required String password}) async {
    try {
      ConstantMethods().showLoaderDialog(context, Colors.purple);
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pop(context);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login({context, required String email, required String password}) async {
    try {
      ConstantMethods().showLoaderDialog(context, Colors.purple);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pop(context);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> googleLogin(context) async {
    try {
      ConstantMethods().showLoaderDialog(context, Colors.purple);
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pop(context);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> facebookLogin(context) async {
    //https://restauranttask-9003c.firebaseapp.com/__/auth/handler
    try {
      ConstantMethods().showLoaderDialog(context, Colors.purple);
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus) {
        final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken!.tokenString);
        await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
        Navigator.pop(context);
        return 'Success';
      } else {
        Navigator.pop(context);
        return 'Failed : ${result.status}';
      }
    } catch (e) {
      Navigator.pop(context);
      return e.toString();
    }
  }

}