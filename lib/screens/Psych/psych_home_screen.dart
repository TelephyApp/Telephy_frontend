import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:telephy/model/users.dart';
import 'package:telephy/services/user_service.dart';
import 'package:telephy/utils/config.dart';
import 'package:telephy/widgets/card_appointment/detail_tile.dart';
import 'package:telephy/widgets/card_appointment/upcoming_card.dart';

class PsychHomeScreen extends StatefulWidget {
  const PsychHomeScreen({super.key});

  @override
  State<PsychHomeScreen> createState() => _PsychHomeScreenState();
}

class _PsychHomeScreenState extends State<PsychHomeScreen> {
  List<Users> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsersAppointment();
  }

  void fetchUsersAppointment() async {
    // users = await UserService().getUserByUID();
  }

  void onSelectedUser(Users users) {
    //pop-up detail
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 64,
        left: 32,
        right: 32,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'สวัสดีตอนบ่าย!\nDr.barbie',
                style: TextStyle(
                  color: Config.darkerToneColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.image,
                color: Colors.grey[400],
                size: 64,
              ),
            ],
          ),
          SizedBox(height: 30),
          UpcomingCard(
            name: 'Malee Wang',
            detail: 'konnichiwa, watashino namaewa',
            dateTime: '12 ส.ค. 2023, 8:00 - 9:00',
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'การนัดหมายทั้งหมด',
                  style: TextStyle(
                    color: Config.darkerToneColor,
                    fontSize: 18,
                  ),
                ),
                Icon(Icons.sort),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(height: 20),
                    DetailTile(
                      name: "${users[index].firstname}",
                      detail: "${users[index].runtimeType}",
                      onclick: () => {onSelectedUser(users[index])},
                    ),
                    SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
