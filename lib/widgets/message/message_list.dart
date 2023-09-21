import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MessageList extends StatelessWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding: const EdgeInsets.only(bottom: 70),
          child: CustomScrollView(reverse: true, slivers: [
            SliverToBoxAdapter(
              child: Container(),
            ),
            SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Container(
                      child: Text("bubu"),
                    );
                  }),
                ))
          ]),
        ));
  }
}
