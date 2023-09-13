import 'dart:ffi';

import 'package:flutter/material.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:get/get.dart';
import 'state.dart';

class VideoController extends GetxController {
  VideoController();

  final state = VideoCallState();
  var isMicrophoneOn = true.obs;
  var isVideoOn = true.obs;


  // final player = AudioPlayer();
  // String appId = APPID;
  // final db = Firebase
}
