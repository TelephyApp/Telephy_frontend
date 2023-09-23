class Chat {
  final String psy_uid;
  final String user_uid;

  Chat({
    required this.psy_uid,
    required this.user_uid,
  });

  //convert to a map
  Map<String, dynamic> toMap() {
    return {
      'psy_uid': psy_uid,
      'user_uid': user_uid,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      psy_uid: map['psy_uid'] ?? '',
      user_uid: map['user_uid'] ?? '',
    );
  }
}
