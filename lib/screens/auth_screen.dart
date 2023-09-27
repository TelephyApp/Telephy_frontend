import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telephy/psych_layout.dart';
import 'package:telephy/screens/login_screen.dart';
import 'package:telephy/services/user_service.dart';
import 'package:telephy/user_layout.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isEmailExist = false;
  void checkEmailExist() async{
    isEmailExist = await UserService().doesEmailExist(FirebaseAuth.instance.currentUser!.email!);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data!.email!.endsWith("@kmitl.ac.th")){
            return PsychLayout();
          }
          else if (snapshot.hasData && isEmailExist) {
            return UserLayout();
          }
          else if(snapshot.hasData && !isEmailExist){
            return 
          }
           else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
