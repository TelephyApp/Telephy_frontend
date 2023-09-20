import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:telephy/pages/message/chat/controller.dart';
import 'package:telephy/routes/names.dart';
import 'package:telephy/utils/config.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  void handleBack() {
    Get.toNamed(AppRoutes.INITIAL);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text("หมอรี ฮ้วง"),
                  pinned: true,
                  centerTitle: true,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFCCADF9),
                          Color(0xFF86D1FC),
                        ],
                      ),
                    ),
                  ),
                  leading: IconButton(
                      onPressed: handleBack,
                      icon: SvgPicture.asset(
                          "assets/images/ionchevron-back-outline.svg")),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(18),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      bool isCurrentUser = index % 2 == 0;

                      Widget chatBubble = DecoratedBox(
                        // chat bubble decoration
                        decoration: BoxDecoration(
                          color: isCurrentUser ? Colors.white : Colors.amber,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            "สวัสดีครับหมอรี",
                            style: Config.normalFont,
                          ),
                        ),
                      );

                      // Define the timestamp widget
                      Widget timestamp = Container(
                        height: 22,
                        margin: EdgeInsets.only(
                            left: isCurrentUser ? 0 : 6,
                            right: isCurrentUser ? 6 : 0),
                        child: Text(
                          "7:00",
                          style: Config.normalFont,
                        ),
                      );

                      // Swap the position of chat bubble and timestamp for even indices
                      if (isCurrentUser) {
                        final temp = chatBubble;
                        chatBubble = timestamp;
                        timestamp = temp;
                      }

                      return Container(
                        child: Column(
                          crossAxisAlignment: isCurrentUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              "น้องเจ๊ม",
                              style: Config.normalFont,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: isCurrentUser
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [chatBubble, timestamp],
                              ),
                            ),
                          ],
                        ),
                      );
                    }, childCount: 20),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Divider(height: 1.0),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextField(
                              decoration: InputDecoration.collapsed(
                                hintText: "Send a message",
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () => {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
