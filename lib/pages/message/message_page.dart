import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telephy/model/users.dart';
import 'package:telephy/pages/message/chat/chats_screen.dart';
import 'package:telephy/widgets/chat/button_message.dart';
import 'package:telephy/services/user_service.dart';

class MessagePage extends StatelessWidget {
  MessagePage({Key? key, required this.context}) : super(key: key);
  final BuildContext context;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void handleBack() {
    Get.toNamed("/main");
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('loading...');
          }
          return ListView(
            children: snapshot.data!
                .get("chat_rooms_id")
                .map((doc) => _buildUserListItem(doc))
                .toList(),
          );
        }));
  }

  Widget _buildUserListItem(String chatRoomId) {
    DocumentSnapshot<Map<String, dynamic>>? docSnap;

    void getDocSnap() async {
      docSnap = await FirebaseFirestore.instance
          .collection('chat_rooms')
          .doc(chatRoomId)
          .get();
    }

    getDocSnap();

    final data = docSnap!.data() as Map<String, dynamic>;

    final recieverId =
        data['user'] == _auth.currentUser!.uid ? data['pys'] : data['user'];

    final Users user = UserService().getUserByUID(recieverId) as Users;

    //display all users except current user
    // if (data['email']) {
    return GestureDetector(
      child: Row(
        children: [
          Text(user.email),
          Text(recieverId),
        ],
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                      reciverUserEmail: user.email,
                      reciverUserID: recieverId,
                    )));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;

    return Container(
        // width: screenWidth,
        color: const Color(0xFFDDDEFC), // Set the background color
        child: Column(children: [
          const SizedBox(height: 50),
          ToggleButton(),
          Expanded(child: _buildUserList())
        ]));
  }
}
