import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:telephy/utils/config.dart';
import 'package:telephy/widgets/card_appointment/detail_tile.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/bg-home-user.png"),
                      fit: BoxFit.cover)),
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(100, 255, 255, 255),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.cloudSun,
                          size: 40,
                        ),
                        Text(
                          "สวัสดีวันนี้คุณเป็นอย่างไรบ้าง ?",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 70,
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  SizedBox(
                    width: 18,
                  ),
                  FaIcon(
                    FontAwesomeIcons.briefcaseMedical,
                    size: 40,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "นักจิตวิทยาของเรา",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Config.mainColor1, Config.accentColor2],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: ListView(
                  children: [
                    SizedBox(height: 20),
                    DetailTile(
                      name: 'มาลี หวัง',
                      dateTime: '12 ส.ค. 2023, 8:00 - 9:00',
                    ),
                    SizedBox(height: 20),
                    DetailTile(
                      name: 'มาลี หวัง',
                      dateTime: '12 ส.ค. 2023, 8:00 - 9:00',
                    ),
                    SizedBox(height: 20),
                    DetailTile(
                      name: 'มาลี หวัง',
                      dateTime: '12 ส.ค. 2023, 8:00 - 9:00',
                    ),
                    SizedBox(height: 20),
                    DetailTile(
                      name: 'มาลี หวัง',
                      dateTime: '12 ส.ค. 2023, 8:00 - 9:00',
                    ),
                    SizedBox(height: 20),
                    DetailTile(
                      name: 'มาลี หวัง',
                      dateTime: '12 ส.ค. 2023, 8:00 - 9:00',
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   height: 60,
            // )
          ],
        ),
      ),
    );
  }
}
