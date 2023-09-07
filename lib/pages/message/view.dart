import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telephy/pages/message/controller.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({super.key});

  Widget _headBar() {
    return Center(
      child: Container(
        width: 320,
        height: 44,
        margin: const EdgeInsets.only(bottom: 20, top: 20),
        child: Row(
          children: [
            Stack(
              children: [GestureDetector()],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.cyan,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [],
            )
          ],
        ),
      ),
    );
  }
}
