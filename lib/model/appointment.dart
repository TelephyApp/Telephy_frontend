class Appointment {
  final String userUid;
  final String psyUid;
  final DateTime startTime;

  Appointment({
    required this.userUid,
    required this.psyUid,
    required this.startTime,
  });

  //convert to a map
  Map<String, dynamic> toMap() {
    return {
      'user_uid': userUid,
      'psy_uid': psyUid,
      'start_time': startTime,
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      userUid: map['user_uid'] ?? '',
      psyUid: map['psy_uid'] ?? '',
      startTime: map['start_time'] ?? DateTime.now(),
    );
  }
}
