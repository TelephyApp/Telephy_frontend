import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telephy/routes/names.dart';

class HeadTab extends StatefulWidget {
  const HeadTab({Key? key}) : super(key: key);

  @override
  _HeadTabState createState() => _HeadTabState();
}

class _HeadTabState extends State<HeadTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 48,
        width: 320,
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        padding: EdgeInsets.all(4),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.Chat);
            },
            child: Container(
              width: 150,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 2))
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Call"),
                ],
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              width: 150,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 2))
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Chat"),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
