import 'package:get/get.dart';

class VideoCallState {
  RxBool inJoined = false.obs;
  RxBool openMicrophone = true.obs;
  RxBool enableSpeaker = true.obs;
  RxString callTime = "00.00".obs;
  RxString callTimeStatus = "not connected".obs;

  var to_token = "".obs;
  var to_name = "Name".obs;
  var to_avatar = "assets/images/erumpic.png".obs;
  var doc_id = "".obs;

  var call_role = "audience".obs;
  var channelId = "".obs;

  RxBool isReadyPreview = false.obs;
  RxBool isShowAvatar = true.obs;
  RxBool enableCamera = true.obs;
  RxBool isMicrophoneOn = true.obs;
  
  RxInt onRemoteUID = 0.obs;
}
