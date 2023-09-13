import 'package:get/get.dart';
import 'package:telephy/main_layout.dart';
import 'package:telephy/message_module/index.dart';
import 'package:telephy/screens/login_screen.dart';
import 'package:telephy/screens/register_screen.dart';
// import 'package:telephy/screens/register_main_screen.dart';
// import 'package:telephy/screens/register_private_screen.dart';
// import 'package:telephy/screens/register_final_screen.dart';

import 'package:telephy/videocall_module/bindings.dart';
import 'package:telephy/videocall_module/calling_screen.dart';
import 'package:telephy/videocall_module/videocall_screen.dart';

class AppPages {
  static final List<GetPage> routes = [
    GetPage(
      name: '/main',
      page: () => MainLayout(),
    ),
    
    GetPage(
      name: '/register',
      page: () => RegisterScreen(),
    ),
    GetPage(
      name: '/video',
      page: () => VideoCallPage(),
      binding: VideoCallBinding(),
    ),
    GetPage(
      name: '/calling',
      page: () => CallingPage(),
      binding: VideoCallBinding(),
    ),
    GetPage(
      name: '/message',
      page: () =>const  MessagePage(),
      binding: MessageBinding(),
      // middlewares: [RouteAuthMiddleware(priority:1),],
    ),
    // GetPage(
    //   name: '/register/main',
    //   page: () => RegisterPrivateScreen(),
    // ),
    // GetPage(
    //   name: '/register/private_info',
    //   page: () => RegisterPrivateScreen(),
    // ),
    // GetPage(
    //   name: '/register/private_info/finish',
    //   page: () => RegisterFinishScreen(),
    // ),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
    ),

  ];
}
