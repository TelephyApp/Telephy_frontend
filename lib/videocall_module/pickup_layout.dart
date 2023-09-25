import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:telephy/model/call.dart';
import 'package:telephy/videocall_module/call_method.dart';
import 'package:telephy/videocall_module/pickup_screen.dart';

class PickupLayout extends StatelessWidget {
  final Widget scaffold;
  final CallMethods callMethods = CallMethods();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  PickupLayout({super.key, required this.scaffold});

  @override
  Widget build(BuildContext context) {
    return (_firebaseAuth.currentUser != null)
        ? StreamBuilder<DocumentSnapshot>(
            stream: callMethods.callStream(uid: _firebaseAuth.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                Call call =
                    Call.fromMap(snapshot.data!.data as Map<String, dynamic>);

                //has dial true for caller
                //false for receiver
                if (!call.hasDialled) {
                  return PickupScreen(call: call);
                }
                return scaffold;
              }
              return scaffold;
            },
          )
        : Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
  }
}
