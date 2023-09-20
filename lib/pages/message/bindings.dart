import 'package:get/get.dart';
import 'package:telephy/pages/message/controller.dart';

class MessageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageController>(() => MessageController());
  }
}
