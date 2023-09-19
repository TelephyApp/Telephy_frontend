import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:telephy/message_module/controller.dart';
import 'package:telephy/videocall_module/controller.dart';
import 'package:telephy/widgets/button_message.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({Key? key}) : super(key: key);


   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ToggleButton()
          
          // CustomScrollView(
          //   slivers: [
          //     SliverAppBar(
          //       pinned: true,
          //       title: ToggleButton(),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
