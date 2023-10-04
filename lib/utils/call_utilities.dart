// import 'dart:math';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:telephy/model/call.dart';
// import 'package:telephy/model/psychologist.dart';
// import 'package:telephy/model/users.dart';
// import 'package:telephy/services/psychologist_service.dart';
// import 'package:telephy/services/user_service.dart';
// import 'package:telephy/videocall_module/call_method.dart';
// import 'package:telephy/videocall_module/videocall_screen_final.dart';

// import 'package:telephy/videocall_module/videocall_screen_test.dart';

// class CallUtils {
//   static final CallMethods callMethods = CallMethods();
//   static dial({required User from, required String to, context}) async {
//     // Users users = GetStateUpdaterMixin;

//     Psychologist? currentPsy =
//         await PsychologistService().getPsyByUID(from.uid);
//     Users? toUser = await UserService().getUserByUID(to);

//     Call call = Call(
//       callerUId: from.uid,
//       callerName: "${currentPsy?.firstname} ${currentPsy?.lastname}",
//       callerPic: "${currentPsy?.imagePath}",
//       receiverId: to,
//       receiverName: "${toUser?.firstname} ${toUser?.lastname}",
//       receiverPic: "${toUser?.imagePath}",
//       channelId: Random().nextInt(1000).toString(),
//       hasDialled: true,
//     );

//     bool callMade = await callMethods.makeCall(call: call);

//     // call.hasDialled = true;

//     if (callMade) {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => VideoCallScreen(),
//             // CallScreen(call: call),
//           ));
//     }
//   }
// }
