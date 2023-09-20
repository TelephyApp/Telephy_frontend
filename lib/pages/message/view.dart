import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:telephy/pages/message/chat/index.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void handleBack() {
    Get.toNamed("/main");
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('user').snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('loading...');
          }
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildUserListItem(doc))
                .toList(),
          );
        }));
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    //display all users except current user
    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: data['email'],

        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChatPage()));
        },
      );
    } else {
      return Center(child: Text("no data"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(padding: EdgeInsets.all(8), child: _buildUserList()),
    );
  }
}
