import 'package:get/get.dart';
import 'package:telephy/message_module/controller.dart';


class MessageBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<VoiceCallController>(() => VoiceCallController());
    Get.put<MessageController>(MessageController());
  }
}
