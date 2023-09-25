import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:telephy/services/chat_service.dart';
import 'package:telephy/utils/call_utilities.dart';
import 'package:telephy/utils/config.dart';


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
          widget.reciverUserID, _messageController.text);

      //clear text controller after sending message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.backgroundColor,
      appBar: AppBar(
        title: Text(widget.reciverUserEmail),
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
      ),
      body: SafeArea(
        child: Column(
          children: [
            //message
            Expanded(child: _buildMessageList()),

            //user input
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: _buildMessageInput(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.reciverUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading...');
        }

        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          reverse: true,
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
    bool isCurrentUser =
        (data['senderId'] == _firebaseAuth.currentUser!.uid) ? true : false;

    DateTime datetime = data['timestamp'].toDate();

    Widget chatBubble = DecoratedBox(
      // chat bubble decoration
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.white : Colors.amber,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Text(
          data['message'],
          style: Config.normalFont,
        ),
      ),
    );

    // Define the timestamp widget
    Widget timeStamp = Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(
          bottom: 2, left: isCurrentUser ? 0 : 6, right: isCurrentUser ? 6 : 0),
      child: Text(
        DateFormat('Hm').format(datetime),
        style: Config.smallFont,
      ),
    );

    if (isCurrentUser) {
      final temp = chatBubble;
      chatBubble = timeStamp;
      timeStamp = temp;
    }

    return Container(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              isCurrentUser ? data['senderEmail'] : data['recieverEmail'],
              style: Config.smallFont,
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            mainAxisAlignment:
                isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [chatBubble, timeStamp],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  // build message input
  Widget _buildMessageInput() {
    return Row(
      children: [
        //text field
        Expanded(
          child: TextField(
            style: TextStyle(decorationThickness: 0),
            controller: _messageController,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              hintText: "พิมพ์ข้อความ...",
              hintStyle: TextStyle(color: Colors.black54),
            ),
          ),
        ),

        //send message
        IconButton(
            onPressed: sendMessage,
            icon: SvgPicture.asset('assets/images/carbon_send-filled.svg'),
            iconSize: 20),

        //videocall
        IconButton(
            onPressed: () =>
                CallUtils.dial(
                  from: _firebaseAuth.currentUser!, 
                  to: widget.reciverUserID),
            icon: SvgPicture.asset('assets/images/carbon_send-filled.svg'),
            iconSize: 20),
      ],
    );
  }
}
