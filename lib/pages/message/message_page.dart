import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telephy/pages/message/chat/chats_screen.dart';
import 'package:telephy/services/psychologist_service.dart';
import 'package:telephy/utils/config.dart';
import 'package:telephy/widgets/chatHistory/chat_history_card.dart';

bool isPsy = false;

class MessagePage extends StatelessWidget {
  MessagePage({Key? key, required this.context}) : super(key: key);
  final BuildContext context;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference psyCollection =
      FirebaseFirestore.instance.collection('psychologists');
  final CollectionReference chatRoomsCollection =
      FirebaseFirestore.instance.collection('chat_rooms');

  void handleBack() {
    Get.toNamed("/main");
  }

  Future<void> isPys() async {
    isPsy = await PsychologistService().isPsychologist(_auth.currentUser!.uid);
  }

  Widget _buildUserList(Stream<DocumentSnapshot<Object?>> stream) {
    return StreamBuilder(
        stream: stream,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
                width: Config.screenWidth,
                child: Center(child: const Text('loading...')));
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
    }

    return FutureBuilder<DocumentSnapshot?>(
        // Access the chat room data using chatRoomSnapshot.data.data()
        future: getChatRoomData(chatRoomId),
        builder: (context, chatRoomSnapshot) {
          if (chatRoomSnapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (chatRoomSnapshot.hasError) {
            return Text('Error: ${chatRoomSnapshot.error}');
          } else if (!chatRoomSnapshot.hasData ||
              !chatRoomSnapshot.data!.exists) {
            return Center(
              child: Text('Chat room data not found'),
            );
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
                        lastMessage: "**************",
                        numberUnseenMessage: 0,
                        timeLastMessage:
                            DateFormat("HH:mm").format(DateTime.now()),
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

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFCCADF9),
                Color(0xFF86D1FC),
              ],
            ),
          ),
        ),
        centerTitle: true,
        title: Text("Chats",
            style: Config.normalFont.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Config.darkerToneColor)),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          // width: screenWidth,
          color: const Color(0xFFDDDEFC), // Set the background color
          child: Column(children: [
            const SizedBox(height: 15),

            // ToggleButton(),
            Expanded(
                child: FutureBuilder(
              future: isPys(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (isPsy) {
                  return _buildUserList(
                      psyCollection.doc(_auth.currentUser!.uid).snapshots());
                } else {
                  return _buildUserList(
                      userCollection.doc(_auth.currentUser!.uid).snapshots());
                }
              },
            ))
          ])),
    );
  }
}
