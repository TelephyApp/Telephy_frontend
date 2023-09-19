import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'state.dart';

class MessageController extends GetxController {
  MessageController();

  final state = MessageState();
  // var db = FirebaseFirestore.instance;

  // goTapStatus() {
  //   EasyLoading.show(
  //       indicator: const CircularProgressIndicator(),
  //       maskType: EasyLoadingMaskType.clear,
  //       dismissOnTap: true);
  //   state.tabStatus.value = !state.tabStatus.value;
  //   if (state.tabStatus.value) {
  //     asyncLoadMsgData();
  //   } else {}
  //   EasyLoading.dismiss();
  // }

  // Future<void> asyncLoadMsgData() async {
  //   current user token
  //   var token = UserStore.to.profile.token;
  //   var from_messages = await  db.collection("message")
  //       .withConverter(
  //        fromFirestore:Msg.fromFirestore, 
  //        toFirestore: (Msg msg, options) => msg.toFirestore()
  //   ).where("from_token",isEqulaTo: token).get();

  //   var to_messages = await  db.collection("message")
  //       .withConverter(
  //        fromFirestore:Msg.fromFirestore, 
  //        toFirestore: (Msg msg, options) => msg.toFirestore()
  //   ).where("to_token",isEqulaTo: token).get();
    
  //   if(from_messages.docs.isNotEmpty){
  //     await addMessage(from_messages.docs);
  //   }

  //   if(to_messages.docs.isNotEmpty){
  //     await addMessage(to_messages.docs);
  //   }
  // }

  // addMessage(List<QueryDocumentSnapShot<MSG>> data){

  // }

  // // @override
  // // void onReady() {
  // //   super.onReady();
  // //   firebaseMessageSetup();
  // // }

  // // @override
  // // void onInit() {
  // //   super.onInit();
  // //   getProfile();
  // //   _snapShots();
  // // }


  // //โหลดหน้าแชทที่มีคนส่งช้อความมาที่ token เรา
  // _snapShots() {
  //   var token = UserStore.to.profile.token;
  //   final toMessageRef = db
  //       .collection("message")
  //       .withConverter(
  //          fromFirestore:Msg.fromFirestore, 
  //          toFirestore: (Msg msg, options) => msg.toFirestore()
  //   ).where("to_token",isEqulaTo: token);

  //   final fromMessageRef = db
  //       .collection("message")
  //       .withConverter(
  //          fromFirestore:Msg.fromFirestore, 
  //          toFirestore: (Msg msg, options) => msg.toFirestore()
  //   ).where("from_token",isEqulaTo: token);
    

  //   //หลังจากมอยู่นหน้านี้และมีคนส่งข้อความมาหรือเราส่งข้อความไปจะไปคอลฟังชั่นเดิมเพื่อรีโหลดหน้า
  //   //automatic update
  //   toMessageRef.snapshots().listen((event){
  //     asyncLoadMsgData();
  //   });
  //   fromMessageRef.snapshots().listen((event){
  //     asyncLoadMsgData();
  //   });
    
  // }
}
