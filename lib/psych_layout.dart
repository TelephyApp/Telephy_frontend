import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:telephy/pages/message/message_page.dart';
import 'package:telephy/screens/Psych/psych_home_screen.dart';
import 'package:telephy/screens/Psych/timesystem_screen.dart';
import 'package:telephy/utils/config.dart';

import 'screens/Psych/psych_profile_screen.dart';

class PsychLayout extends StatefulWidget {
  const PsychLayout({Key? key}) : super(key: key);

  @override
  State<PsychLayout> createState() => _PsychLayoutState();
}

class _PsychLayoutState extends State<PsychLayout> {
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
          PsychHomeScreen(),
          TimeSlotSystemScreen(),
          MessagePage(
            context: context,
          ),
          PsychProfileScreen(),
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
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 6.0,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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
                      FontAwesomeIcons.calendar,
                      color: Config.mainColor1,
                    ),
                    onPressed: () {
                      onTap(1);
                    },
                  ),
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.comment,
                      color: Config.mainColor1,
                    ),
                    onPressed: () {
                      onTap(2);
                    },
                  ),
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.user,
                      color: Config.mainColor1,
                    ),
                    onPressed: () {
                      onTap(3);
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
