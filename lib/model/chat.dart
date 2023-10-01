import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String id;
  final String doctorId;
  final String userId;
  final Timestamp createdAt; // Firestore timestamp
  final bool isEnable;

  Chat(
      {required this.id,
      required this.doctorId,
      required this.userId,
      required this.createdAt,
      this.isEnable = false});

  factory Chat.fromMap(String id, Map<String, dynamic> data) {
    return Chat(
      id: id,
      doctorId: data['doctorId'] ?? '',
      userId: data['userId'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      isEnable: data['is_enable'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'doctorId': doctorId,
      'userId': userId,
      'createdAt': createdAt,
      'is_enable': isEnable,
    };
  }
}
