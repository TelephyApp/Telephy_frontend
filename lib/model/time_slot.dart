import 'package:cloud_firestore/cloud_firestore.dart';

class Timeslot {
  final String id;
  final String psyId;
  final Timestamp startTime;

  Timeslot({
    required this.id,
    required this.psyId,
    required this.startTime,
  });

  //convert to a map
  Map<String, dynamic> toMap() {
    return {
      'timeslot_id': id,
      'psy_id': psyId,
      'start_time': startTime,
    };
  }

  factory Timeslot.fromMap(Map<String, dynamic> map) {
    return Timeslot(
      id: map['id'] ?? '',
      psyId: map['psy_id'] ?? '',
      startTime: map['start_time'] ?? Timestamp.now(),
    );
  }
}
