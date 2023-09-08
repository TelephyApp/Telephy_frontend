import 'package:get/get.dart';
import 'package:telephy/main_layout.dart';
import 'package:telephy/screens/login_screen.dart';
import 'package:telephy/screens/register_final_screen.dart';
import 'package:telephy/screens/register_main_screen.dart';
import 'package:telephy/screens/register_private_screen.dart';
import 'package:telephy/screens/video_main.dart';

class AppPages {
  static final List<GetPage> routes = [
    GetPage(
      name: '/main',
      page: () => MainLayout(),
    ),
    GetPage(
      name: '/video',
      page: () => VideoScreen(),
    ),
    GetPage(
      name: '/register',
      page: () => RegisterMainScreen(),
    ),
    GetPage(
      name: '/register/private_info',
      page: () => RegisterPrivateScreen(),
    ),
    GetPage(
      name: '/register/private_info/finish',
      page: () => RegisterFinishScreen(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
    ),
  ];
}
