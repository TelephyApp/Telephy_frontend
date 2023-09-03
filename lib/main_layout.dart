import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:telephy/screens/chatlogs_screen.dart';
import 'package:telephy/screens/home_screen.dart';
import 'package:telephy/screens/profile_screen.dart';
import 'package:telephy/utils/config.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentPage = 1;
            _page.animateToPage(
              1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });
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
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: Config.baseColor,
            type: BottomNavigationBarType.fixed,
            elevation: 20,
            showSelectedLabels: false,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            iconSize: 20,
            currentIndex: currentPage,
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
            items: const [
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.house,
                  color: Config.mainColor1,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.comment,
                  color: Colors.transparent,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.user,
                  color: Config.mainColor1,
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
