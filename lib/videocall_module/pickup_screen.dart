import 'dart:js_util';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:telephy/model/call.dart';
import 'package:telephy/routes/pages.dart';
import 'package:telephy/videocall_module/call_method.dart';

import 'package:telephy/videocall_module/videocall_screen.dart';
import 'package:telephy/videocall_module/videocall_screen_final.dart';
import 'package:telephy/videocall_module/videocall_screen_test.dart';

class PickupScreen extends StatelessWidget {
  late final Call call;
  final CallMethods callMethods = CallMethods();

  PickupScreen({required this.call});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Obx(() => Container(
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/docpic.png"),
                          filterQuality: FilterQuality.low,
                          opacity: 0.3,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 30,
                    right: 30,
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            call.callerName,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        // Container(
                        //   width: 70,
                        //   height: 100,
                        //   margin: EdgeInsets.only(top: 150),
                        //   child: Image.asset(
                        //       "${controller.state.to_avatar.value}"),
                        // ),
                        // Text(
                        //   "${controller.state.to_name.value}",
                        //   style: TextStyle(
                        //     fontSize: 18,
                        //     color: Colors.white,
                        //     fontWeight: FontWeight.normal,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 80,
                    left: 50,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                    color: Colors.red),
                                child: IconButton(
                                  iconSize: 40,
                                  color: Colors.white,
                                  icon: FaIcon(FontAwesomeIcons.phoneSlash),
                                  onPressed: () async {
                                    await callMethods.endCall(call: call);
                                    print("decline");
                                  },
                                ),
                              ),
                            ),
                            Container(
                              child: Text("Decline",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 80,
                      right: 50,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      color: const Color.fromARGB(
                                          255, 43, 219, 49)),
                                  child: IconButton(
                                    iconSize: 40,
                                    color: Colors.white,
                                    icon: FaIcon(FontAwesomeIcons.phone),
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            // CallScreen(call: call),
                                            VideoCallScreen(call: call),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Accept",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                              )
                            ],
                          )
                        ],
                      ))
                ],
              ),
            )),
      ),
    );
  }
}
