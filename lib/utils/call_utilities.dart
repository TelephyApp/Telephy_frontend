import 'dart:math';


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:telephy/model/call.dart';
import 'package:telephy/videocall_module/call_method.dart';
import 'package:telephy/videocall_module/test_screen.dart';
import 'package:telephy/videocall_module/videocall_screen_test.dart';
import 'package:telephy/model/user.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();
  static dial({required User from, required User to, context}) async {
    // Users users = GetStateUpdaterMixin;

    Call call = Call(
      callerId: from.uid,
      callerName: from.name,
      callerPic: from.profilePhoto,

      receiverId: to.uid,
      receiverName: to.name,
      receiverPic: to.profilePhoto,
      channelId: Random().nextInt(1000).toString(),
      hasDialled: true,
    );

    bool callMade = await callMethods.makeCall(call: call);

    // call.hasDialled = true;

    if (callMade) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TestCallScreen(call: call),
          ));
    }
  }
}
