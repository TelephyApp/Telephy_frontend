import 'package:flutter/material.dart';
import 'package:telephy/widgets/chat/button_message.dart';
import 'package:telephy/widgets/chatHistory/chat_history_card.dart';

class ChatHistory extends StatefulWidget {
  const ChatHistory({super.key});

  @override
  State<ChatHistory> createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistory> {
  static const double marginBtwSmall = 10;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: screenWidth,
        color: const Color(0xFFDDDEFC), // Set the background color
        child: Column(
          children: [
            const SizedBox(height: 50), // Space
            ToggleButton(),
            Expanded(
              // Use Expanded to make the ListView take all available space
              child: ListView(
                padding: const EdgeInsets.all(30),
                children: const <Widget>[
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
                  // Add more ChatCard widgets as needed
                ],
              ),
            ), // Space
          ],
        ),
      ),
    );
  }
}
