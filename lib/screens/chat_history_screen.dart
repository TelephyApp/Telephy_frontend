import 'package:flutter/material.dart';
import 'package:telephy/widgets/chatHistory/chat_history_card.dart';

class chatHistory extends StatefulWidget {
  const chatHistory({super.key});

  @override
  State<chatHistory> createState() => _chatHistoryState();
}

class _chatHistoryState extends State<chatHistory> {
  static const double marginBtwSmall = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatHistory'),
      ),
      body: Container(
        color: const Color(0xFFDDDEFC), // Set the background color
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: const <Widget>[
            SizedBox(height: marginBtwSmall),
            ChatCard(
              username: 'นักจิตวิทยา 1',
              lastMessage: 'สวัสดี ทำอะไรอยู่',
              numberUnseenMessage: 2,
              timeLastMessage: '10:30',
            ),
            SizedBox(height: marginBtwSmall),
            ChatCard(
              username: 'นักจิตวิทยา 2',
              lastMessage: 'สวัสดี ทำอะไรอยู่',
              numberUnseenMessage: 0,
              timeLastMessage: '11:45',
            ),
            SizedBox(height: marginBtwSmall),
            ChatCard(
              username: 'นักจิตวิทยา 3',
              lastMessage: 'สวัสดี ทำอะไรอยู่',
              numberUnseenMessage: 999,
              timeLastMessage: '23:45',
            ),
            SizedBox(height: marginBtwSmall),
            ChatCard(
              username: 'นักจิตวิทยา 4',
              lastMessage: 'สวัสดี ทำอะไรอยู่',
              numberUnseenMessage: 10,
              timeLastMessage: '5:45',
            ),
            SizedBox(height: marginBtwSmall),
            // Add more ChatBox widgets as needed
          ],
        ),
      ),
    );
  }
}
