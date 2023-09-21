import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telephy/services/chat_service.dart';
import 'package:telephy/utils/config.dart';
import 'package:telephy/widgets/textfield_login.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key, required this.reciverUserEmail, required this.reciverUserID});

  final String reciverUserEmail;
  final String reciverUserID;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void handleBack() {
    Navigator.pop(context);
  }

  void sendMessage() async {
    //only send message if there is not Empty
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.reciverUserID, widget.reciverUserEmail);

      //clear text controller after sending message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.backgroundColor,
      appBar: AppBar(title: Text(widget.reciverUserEmail)),
      body: SafeArea(
          child: Column(
        children: [
          //message
          Expanded(
            child: _buildMessageList(),
          ),

          //user input
          _buildMessageInput(),
        ],
      )),
    );
  }

  //build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.reciverUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container();
        } else if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading...');
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    //align the message to the right if the sender is the current user
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text(data['senderEmail']),
          Text(data['message']),
        ]),
      ),
    );
  }

  // build message input
  Widget _buildMessageInput() {
    return Row(
      children: [
        //text field
        Expanded(
            child: MyTextField(
          controller: _messageController,
          hintText: "enter message",
          obscureText: false,
          prefixIcon: null,
        )),

        //send button
        IconButton(
          onPressed: sendMessage,
          icon: const Icon(
            Icons.arrow_upward,
            size: 40,
          ),
        )
      ],
    );
  }
}
