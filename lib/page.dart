import 'package:get/get.dart';
import 'pages/message/index.dart';

class AppPages {
  static final List<GetPage> routes = [
    GetPage(
      name: '/message',
      page: () => MessagePage(),
      binding: MessageBinding(),
    ),
  ];
}
