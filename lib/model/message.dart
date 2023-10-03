import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String recieverId;
  final String recieverEmail;
  final String message;
  final Timestamp timestamp;
  final String type;
  final String callTime;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.recieverId,
    required this.recieverEmail,
    required this.message,
    required this.timestamp,
    required this.type,
    required this.callTime,
  });

  //convert to a map
  Map<String, dynamic> toMap() {
    return {
      'sender_id': senderId,
      'sender_email': senderEmail,
      'reciever_id': recieverId,
      'reciever_email': recieverEmail,
      'message': message,
      'timestamp': timestamp,
      'type': type,
      'call_time': callTime,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['sender_id'] ?? '',
      senderEmail: map['sender_email'] ?? '',
      recieverId: map['reciever_id'] ?? '',
      recieverEmail: map['reciever_email'] ?? '',
      message: map['message'] ?? '',
      timestamp: map['timestamp'] ?? '',
      type: map['type'] ?? '',
      callTime: map['call_time'] ?? '',
    );
  }
}
