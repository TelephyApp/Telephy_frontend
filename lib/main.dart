import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:telephy/main_layout.dart';
import 'package:telephy/screens/auth_screen.dart';
import 'package:telephy/screens/booking_screen.dart';
import 'package:telephy/screens/chatlogs_screen.dart';
import 'package:telephy/screens/profile_screen.dart';
import 'package:telephy/screens/register_screen.dart';
import 'package:telephy/screens/time_slot_screen.dart';
=======
import 'package:get/get.dart';
import 'package:telephy/routes/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

>>>>>>> 95c1daa9d2be5831a2c1a13a95b74bb27adf4d62
import 'package:telephy/utils/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Telephy',
      theme: ThemeData(
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
<<<<<<< HEAD
      initialRoute: 'timeSlot',
      routes: {
        '/': (context) => const AuthScreen(),
        'main': (context) => const MainLayout(),
        'chatlogs': (context) => const ChatLogsScreen(),
        'profile': (context) => const ProfileScreen(),
        'register': (context) => const RegisterScreen(),
        'booking': (context) => const BookingScreen(),
        'timeSlot': (context) => const TimeSlot(),
      },
=======
      initialRoute: 'login',
      getPages: AppPages.routes,
>>>>>>> 95c1daa9d2be5831a2c1a13a95b74bb27adf4d62
    );
  }
}
