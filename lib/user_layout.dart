import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:telephy/screens/User/profile_screen.dart';
import 'package:telephy/screens/User/user_home_screen.dart';
import 'package:telephy/utils/config.dart';
import 'package:telephy/pages/message/message_page.dart';

class UserLayout extends StatefulWidget {
  const UserLayout({Key? key}) : super(key: key);

  @override
  State<UserLayout> createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout> {
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
        children: [
          UserHomeScreen(),
          MessagePage(
            context: context,
          ),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.transparent),
        child: Container(
          height: 55,
          decoration: BoxDecoration(
            color: Config.baseColor,
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
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(30.0),
            ),
            child: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 6.0,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.home_outlined,
                        color: currentPage == 0
                            ? Config.mainColor1
                            // : Color.fromARGB(255, 235, 235, 235),
                            : Config.lighterToneColor,
                        size: 32,
                      ),
                      onPressed: () {
                        if (currentPage != 0) {
                          _pageController.jumpToPage(0);
                        }
                      },
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.comment,
                        color: currentPage == 1
                            ? Config.mainColor1
                            // : Color.fromARGB(255, 235, 235, 235),
                            : Config.lighterToneColor,
                      ),
                      onPressed: () {
                        if (currentPage != 1) {
                          _pageController.jumpToPage(1);
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.user,
                        color: currentPage == 2
                            ? Config.mainColor1
                            // : Color.fromARGB(255, 235, 235, 235),
                            : Config.lighterToneColor,
                      ),
                      onPressed: () {
                        if (currentPage != 2) {
                          _pageController.jumpToPage(2);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
