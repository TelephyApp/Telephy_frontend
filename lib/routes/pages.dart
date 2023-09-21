import 'package:get/get.dart';
import 'package:telephy/main_layout.dart';
import 'package:telephy/pages/message/chat/index.dart';
import 'package:telephy/screens/login_screen.dart';
import 'package:telephy/screens/register_screen.dart';
import 'package:telephy/pages/message/index.dart';
import '../screens/auth_screen.dart';

class AppPages {
  static final List<GetPage> routes = [
    GetPage(
      name: '/main',
      page: () => MainLayout(),
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
      page: () => AuthScreen(),
    ),
  ];
}
