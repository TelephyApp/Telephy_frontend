import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telephy/model/message.dart';
import 'package:telephy/model/psychologist.dart';
import 'package:telephy/model/users.dart';
import 'package:telephy/services/psychologist_service.dart';
import 'package:telephy/services/user_service.dart';

class ChatService extends ChangeNotifier {
  //get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //send message
  Future<void> sendMessage(
      String recieverId, String message) async {
    //get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();
    final String type = "normal_message";
    final String callTime = ""; //create a new message
    Message newMessage = Message(
      senderId: currentUserId,
      recieverId: recieverId,
      message: message,
      timestamp: timestamp,
      type: type,
      callTime: callTime,
    );
    //construct chat room id from current user id and reciever id
    List<String> ids = [currentUserId, recieverId];
    ids.sort();
    String chatRoomId = ids.join("_");
    //add new message to database
    await _fireStore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //Get message
  Stream<QuerySnapshot> getMessages(String userId, String otherUsesrId) {
    //construct chat room id from user ids (sorted to ensure it matches the id used when sending message)
    List<String> ids = [userId, otherUsesrId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<String> createChatRoom(
      String psyId, String userId) async {
    try {
      final CollectionReference chatRoomsCollection =
          FirebaseFirestore.instance.collection('chat_rooms');
      List<String> ids = [userId, psyId];
      ids.sort();
      String chatRoomId = ids.join("_");
      final DocumentReference chatRoomDocRef =
          chatRoomsCollection.doc(chatRoomId);
      Psychologist? psy = await PsychologistService().getPsychologistByUID(psyId);
      Users? users = await UserService().getUserByUID(userId);

      await chatRoomDocRef.set({
        'psyId': psyId,
        'userId': userId,
        'psyName': '${psy?.firstname} ${psy?.lastname}',
        'userName': '${users?.firstname} ${users?.lastname}',
      });

      return chatRoomDocRef.id;
    } catch (error) {
      print('Error creating chat room: $error');
      return '';
    }
  }
}
