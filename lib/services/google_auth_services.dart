import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:telephy/model/psychologist.dart';
import 'package:telephy/screens/register_google.dart';
import 'package:telephy/services/psychologist_service.dart';
import 'package:telephy/services/user_service.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';
import 'package:telephy/model/psychologist.dart';
import 'package:telephy/services/psychologist_service.dart';

class GoogleAuthService {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn().catchError((onError) => print(onError));
      if (googleSignInAccount == null) return null;

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential authResult =
            await _auth.signInWithCredential(authCredential);
        final User? user = authResult.user;

        if (user != null) {
          if ((user.email ?? "").endsWith("@kmitl.ac.th") &&
              !(await PsychologistService().checkEmailExist())) {
            await createPsychologist(user);
          }
          return user;
        } else {
          await _auth.signOut();
          await _googleSignIn.signOut();
          return null;
        }
      }
    } catch (e) {
      print(e); // Handle other platform exceptions appropriately
    }
  }

  Future<void> createPsychologist(User user) async {
    final psychologist = Psychologist(
      firstname: "None",
      lastname: "None",
      detail: "None",
      gender: "None",
      age: 0,
      phone: "None",
      hospital: "None",
      ratePerHours: "ratePerHours",
    );
    await PsychologistService().storePsychData(user, psychologist);
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
