import 'package:flutter/material.dart';

class ChatLogsScreen extends StatefulWidget {
  const ChatLogsScreen({super.key});

  @override
  State<ChatLogsScreen> createState() => _ChatLogsScreenState();
}

class _ChatLogsScreenState extends State<ChatLogsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Chattt"),
        ],
      ),
    );
  }
}
