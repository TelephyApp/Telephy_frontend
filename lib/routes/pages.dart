import 'package:get/get.dart';
import 'package:telephy/psych_layout.dart';
import 'package:telephy/pages/message/chat/index.dart';
import 'package:telephy/screens/login_screen.dart';
import 'package:telephy/screens/register_screen.dart';
import 'package:telephy/pages/message/index.dart';

import 'package:telephy/user_layout.dart';

import 'package:telephy/screens/chat_history_screen.dart';


class AppPages {
  static final List<GetPage> routes = [
    GetPage(
      name: '/main-user',
      page: () => const UserLayout(),
    ),
    GetPage(
      name: '/main-psych',
      page: () => const PsychLayout(),
    ),
    GetPage(
      name: '/message',
      page: () => const MessageScreen(),
      binding: MessageBinding(),
    ),
    GetPage(
      name: '/chat',
      page: () => const ChatPage(),
    ),
    GetPage(
      name: '/register',
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: '/login',
      page: () => const LoginPage(),
    ),
    GetPage(
      name: '/chatHistory',
      page: () => const ChatHistory(),
    ),
  ];
}
