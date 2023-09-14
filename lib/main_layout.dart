import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:telephy/screens/home_screen.dart';
import 'package:telephy/screens/profile_screen.dart';
import 'package:telephy/screens/time_slot_screen.dart';
import 'package:telephy/utils/config.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  void onPageChanged(int page) {
    setState(() {
      currentPage = page;
    });
  }

  void onTap(int page) {
    setState(() {
      currentPage = page;
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: const <Widget>[
          HomeScreen(),
          TimeSlotScreen(),
          ProfileScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onTap(1);
        },
        elevation: 8,
        backgroundColor: Config.baseColor,
        child: const FaIcon(
          FontAwesomeIcons.comment,
          color: Config.mainColor1,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        height: 55,
        decoration: const BoxDecoration(
          color: Config.baseColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 6.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.home,
                    color: Config.mainColor1,
                  ),
                  onPressed: () {
                    onTap(0);
                  },
                ),
                IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.user,
                    color: Config.mainColor1,
                  ),
                  onPressed: () {
                    onTap(2);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
