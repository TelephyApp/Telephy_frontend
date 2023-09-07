import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telephy/main_layout.dart';
import 'package:telephy/screens/auth_screen.dart';
import 'package:telephy/screens/calendar_screen.dart';
import 'package:telephy/screens/booking_screen.dart';
import 'package:telephy/screens/chatlogs_screen.dart';
import 'package:telephy/screens/login_screen.dart';
import 'package:telephy/screens/profile_screen.dart';
import 'package:telephy/screens/video_main.dart';
import 'package:telephy/screens/register_screen.dart';
import 'package:telephy/screens/timesystem_screen.dart';
import 'package:telephy/utils/config.dart';

import 'page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      //set theme
      theme: ThemeData(
        //pre-define input decoration
        fontFamily: 'Mitr',
        inputDecorationTheme: const InputDecorationTheme(
          focusColor: Config.mainColor1,
          border: Config.outlinedBorder,
          focusedBorder: Config.focusBorder,
          errorBorder: Config.errorBorder,
          enabledBorder: Config.outlinedBorder,
          floatingLabelStyle: TextStyle(color: Config.mainColor1),
          prefixIconColor: Colors.black38,
        ),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Config.mainColor1,
          selectedItemColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey.shade700,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      initialRoute: 'message',
      getPages: AppPages.routes,
      routes: {
        '/': (context) => const AuthScreen(),
        'main': (context) => const MainLayout(),
        'chatlogs': (context) => const ChatLogsScreen(),
        'profile': (context) => const ProfileScreen(),
        'video': (context) => const VideoScreen(),
        'calendar': (context) => const CalendarScreen(),
        'timesystem': (context) => const TimeSystemScreen(),
        'register': (context) => const RegisterScreen(),
        'booking': (context) => const BookingScreen(),
        'login': (context) => const LoginPage(),
      },
    );
  }
}
