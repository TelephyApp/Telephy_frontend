import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String recieverId;
  final String message;
  final Timestamp timestamp;
  final String type;
  final String callTime;

  Message({
    required this.senderId,
    required this.recieverId,
    required this.message,
    required this.timestamp,
    required this.type,
    required this.callTime,
  });

  //convert to a map
  Map<String, dynamic> toMap() {
    return {
      'sender_id': senderId,
      'reciever_id': recieverId,
      'message': message,
      'timestamp': timestamp,
      'type': type,
      'call_time': callTime,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['sender_id'] ?? '',
      recieverId: map['reciever_id'] ?? '',
      message: map['message'] ?? '',
      timestamp: map['timestamp'] ?? '',
      type: map['type'] ?? '',
      callTime: map['call_time'] ?? '',
    );
  }
}
