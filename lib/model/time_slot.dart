class Timeslot {
  final String psyname;
  final String startTime;

  Timeslot({
    required this.psyname,
    required this.startTime,
  });

  //convert to a map
  Map<String, dynamic> toMap() {
    return {
      'psyname': psyname,
      'start_time': startTime,
    };
  }

  factory Timeslot.fromMap(Map<String, dynamic> map) {
    return Timeslot(
      psyname: map['psyname'] ?? '',
      startTime: map['start_time'] ?? DateTime.now(),
    );
  }

  
}
