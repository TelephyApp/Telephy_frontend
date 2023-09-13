import 'package:get/get.dart';
import 'controller.dart';

class VideoCallBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<VoiceCallController>(() => VoiceCallController());
    Get.put<VideoController>(VideoController());
  }
}
