import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telephy/pages/message/chat/chats_screen.dart';
import 'package:telephy/widgets/chat/button_message.dart';
import 'package:telephy/widgets/chatHistory/chat_history_card.dart';

class MessagePage extends StatelessWidget {
  MessagePage({Key? key, required this.context}) : super(key: key);
  final BuildContext context;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');
  final CollectionReference chatRoomsCollection =
      FirebaseFirestore.instance.collection('chat_rooms');

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
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList(),
          );
        }));
  }

  Widget _buildUserListItem(String chatRoomId) {
    Future<DocumentSnapshot?> getChatRoomData(String chatRoomId) async {
      try {
        // Get the chat room document in the 'chat_rooms' collection
        return chatRoomsCollection.doc(chatRoomId).get();
      } catch (e) {
        print('Error getting chat room data: $e');
      }
      return null;
    }

    // final recieverId = chatRoom['user'] == _auth.currentUser!.uid
    //     ? chatRoom['pys']
    //     : chatRoom['user'];

    return FutureBuilder<DocumentSnapshot?>(
        // Access the chat room data using chatRoomSnapshot.data.data()
        future: getChatRoomData(chatRoomId),
        builder: (context, chatRoomSnapshot) {
          if (chatRoomSnapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (chatRoomSnapshot.hasError) {
            return Text('Error: ${chatRoomSnapshot.error}');
          } else if (!chatRoomSnapshot.hasData) {
            return Text('Chat room data not found');
          } else {
            // Access the chat room data using chatRoomSnapshot.data.data()
            Map<String, dynamic> chatRoomData =
                chatRoomSnapshot.data!.data() as Map<String, dynamic>;
            String recieverId;
            String recieverName;

            if (chatRoomData['userId'] == _auth.currentUser!.uid) {
              recieverId = chatRoomData['psyId'];
              recieverName = chatRoomData['psyName'];
            } else {
              recieverId = chatRoomData['userId'];
              recieverName = chatRoomData['userName'];
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    child: ChatCard(
                        lastMessage: "dasdas",
                        numberUnseenMessage: 4,
                        timeLastMessage: "haha",
                        username: recieverName),
                    onTap: () => Get.to(() => ChatScreen(
                          reciverUserName: recieverName,
                          reciverUserID: recieverId,
                        )))
              ],
            );
          }
        });
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
