import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';

import '../../root_screen.dart';
import '../../services/my_app_method.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  Future<void> _googleSignIn({required BuildContext context}) async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleAccount = await googleSignIn.signIn();
      if (googleAccount != null) {
        final googleAuth = await googleAccount.authentication;
        if (googleAuth.accessToken != null && googleAuth.idToken != null) {
          final authResult = await FirebaseAuth.instance.signInWithCredential(
            GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            ),
          );
          if(authResult.additionalUserInfo!.isNewUser) {
            await FirebaseFirestore.instance.collection("users").doc(authResult.user!.uid).set({
              "userId" : authResult.user!.uid,
              "userName" : authResult.user!.displayName,
              "userImage" : authResult.user!.photoURL,
              "userEmail" : authResult.user!.email,
              "createAt" : Timestamp.now(),
              "userWish" : [],
              "userCart" : [],
            });
          }
        }
      }
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushReplacementNamed(context, RootScreen.routeName);
      });
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      await MyAppMethods.showErrorORWarningDialog(
          context: context, subtitle: error.message.toString(), fct: () {});
    } catch (error) {
      if (!context.mounted) return;
      await MyAppMethods.showErrorORWarningDialog(
          context: context, subtitle: error.toString(), fct: () {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(12),
        backgroundColor: const Color(0xff233743),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
      ),
      icon: const Icon(
        Ionicons.logo_google,
        color: Colors.red,
      ),
      label: const Text(
        "Sign in with google",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.white,
        ),
      ),
      onPressed: () async {
        await _googleSignIn(context: context);
      },
    );
  }
}
