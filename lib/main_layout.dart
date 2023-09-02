import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:telephy/screens/chatlogs_screen.dart';
import 'package:telephy/screens/home_screen.dart';
import 'package:telephy/screens/profile_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  //variable declaration
  int currentPage = 0;
  final PageController _page = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _page,
        onPageChanged: ((value) {
          setState(() {
            currentPage = value;
          });
        }),
        children: const <Widget>[
          HomeScreen(),
          ChatLogsScreen(),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: StylishBottomBar(
        option: AnimatedBarOptions(
            
        ),
        currentIndex: currentPage,
        fabLocation: StylishBarFabLocation.center,
        onTap: (page) {
          setState(() {
            currentPage = page;
            _page.animateToPage(
              page,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });
        },
        items: <BottomBarItem>[
          BottomBarItem(
            icon: const FaIcon(FontAwesomeIcons.house),
            title: const Text('Home'),
            backgroundColor: Colors.red,
          ),
          BottomBarItem(
            icon: const FaIcon(FontAwesomeIcons.comment),
            title: const Text('Chat'),
            backgroundColor: Colors.orange,
          ),
          BottomBarItem(
            icon: const FaIcon(FontAwesomeIcons.user),
            title: const Text('Profile'),
            backgroundColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}
