import 'package:get/get.dart';
import 'package:telephy/psych_layout.dart';
import 'package:telephy/pages/message/chat/index.dart';
import 'package:telephy/screens/login_screen.dart';
import 'package:telephy/screens/register_screen.dart';
import 'package:telephy/pages/message/index.dart';
import 'package:telephy/user_layout.dart';

class AppPages {
  static final List<GetPage> routes = [
    GetPage(
      name: '/main-user',
      page: () => UserLayout(),
    ),
    GetPage(
      name: '/main-psych',
      page: () => PsychLayout(),
    ),
    GetPage(
      name: '/message',
      page: () => MessageScreen(),
      binding: MessageBinding(),
    ),
    GetPage(
      name: '/chat',
      page: () => ChatPage(),
    ),
    GetPage(
      name: '/register',
      page: () => RegisterScreen(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
    ),
  ];
}
