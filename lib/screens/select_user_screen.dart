import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telephy/psych_layout.dart';
import 'package:telephy/screens/login_screen.dart';
import 'package:telephy/screens/register_google.dart';
import 'package:telephy/services/user_service.dart';
import 'package:telephy/user_layout.dart';

class SelectUserScreen extends StatefulWidget {
  const SelectUserScreen({super.key});

  @override
  State<SelectUserScreen> createState() => _SelectUserScreenState();
}

class _SelectUserScreenState extends State<SelectUserScreen> {
  bool isEmailExist = false;
  String? email;
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> checkEmailExist() async {
    String provider = await UserService().getLoggedInProvider();
    if (provider == "Google") {
      email = await UserService().getGoogleSignInEmail();
    } else {
      email = FirebaseAuth.instance.currentUser!.email;
    }
    isEmailExist = await UserService().doesEmailExist(email!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkEmailExist(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!isEmailExist && !(user?.email ?? "").endsWith("@kmitl.ac.th")) {
            return RegistGoogle();
          }
          
          if ((user?.email ?? "").endsWith("@kmitl.ac.th")) {
            return PsychLayout();
          } else {
            return UserLayout();
          }
        },
      ),
    );
  }
}
