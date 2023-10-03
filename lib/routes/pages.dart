import 'package:get/get.dart';
import 'package:telephy/pages/message/chat/chats_screen.dart';
import 'package:telephy/psych_layout.dart';
import 'package:telephy/screens/register_google.dart';
import 'package:telephy/screens/register_screen.dart';
import '../screens/auth_screen.dart';
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
      name: '/chat',
      page: () => ChatScreen(
          reciverUserEmail: "asdjhkdujksa", reciverUserID: "dsadhjkaskd"),
    ),
    GetPage(
      name: '/register',
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: '/register-google',
      page: () => const RegistGoogle(),
    ),
    GetPage(
      name: '/login',
      page: () => AuthScreen(),
    ),
    GetPage(
      name: '/chatHistory',
      page: () => const ChatHistory(),
    ),
  ];
}
