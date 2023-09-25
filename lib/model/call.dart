class Call {
  final String callerUId;
  final String callerName;
  final String callerPic;
  final String receiverId;
  final String receiverName;
  final String receiverPic;
  final String channelId;
  late bool hasDialled;

  Call({
    required this.callerUId,
    required this.callerName,
    required this.callerPic,
    required this.receiverId,
    required this.receiverName,
    required this.receiverPic,
    required this.channelId,
    required this.hasDialled,
  });

  //convert to a map
  Map<String, dynamic> toMap() {
    return {
      'caller_uid': callerUId,
      'caller_name': callerName,
      'caller_pic': callerPic,
      'receiver_uid': receiverId,
      'receiver_name': receiverName,
      'receiver_pic': receiverPic,
      'channel_id': channelId,
      'hasDialled': hasDialled,
    };
  }

  factory Call.fromMap(Map<String, dynamic> map) {
    return Call(
      callerUId: map['caller_uid'] ?? '',
      callerName: map['caller_name'] ?? '',
      callerPic: map['caller_pic'] ?? '',
      receiverId: map['receiver_uid'] ?? '',
      receiverName: map['receiver_name'] ?? '',
      receiverPic: map['receiver_pic'] ?? '',
      channelId: map['channel_id'] ?? '',
      hasDialled: map['hasDialled'] ?? true,
    );
  }
}
