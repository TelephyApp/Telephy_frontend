import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: signUserOut,
          icon: Icon(Icons.logout),
        )
      ]),
      body: Center(
        child: Text("Profile"),
      ),
    );
  }
}
