import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:telephy/screens/User/user_profile_screen.dart';
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
      _pageController.jumpToPage(page);
      // _pageController.animateToPage(
      //   page,
      //   duration: const Duration(milliseconds: 500),
      //   curve: Curves.easeInOut,
      // );
    });
  }

  final List<IconData> _outlineIcons = [
    Icons.home_outlined,
    FontAwesomeIcons.comment,
    FontAwesomeIcons.user,
  ];

  final List<IconData> _filledIcons = [
    Icons.home,
    FontAwesomeIcons.solidComment,
    FontAwesomeIcons.solidUser,
  ];

  Color getIconColor(int index) {
    return currentPage == index ? Config.mainColor1 : Config.lighterToneColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
        children: [
          UserHomeScreen(),
          MessagePage(
            context: context,
          ),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
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
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(
                      currentPage == 0 ? _filledIcons[0] : _outlineIcons[0],
                      color: getIconColor(0),
                      size: 32,
                    ),
                    onPressed: () {
                      onTap(0);
                    },
                  ),
                  IconButton(
                    icon: FaIcon(
                      currentPage == 1 ? _filledIcons[1] : _outlineIcons[1],
                      color: getIconColor(1),
                    ),
                    onPressed: () {
                      onTap(1);
                    },
                  ),
                  IconButton(
                    icon: FaIcon(
                      currentPage == 2 ? _filledIcons[2] : _outlineIcons[2],
                      color: getIconColor(2),
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
      ),
    );
  }
}
