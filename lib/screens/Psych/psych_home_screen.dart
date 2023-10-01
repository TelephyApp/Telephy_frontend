import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:telephy/model/appointment.dart';
import 'package:telephy/model/psychologist.dart';
import 'package:telephy/model/users.dart';
import 'package:telephy/services/psychologist_service.dart';
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
  String? loggedInPsychologistName;
  late final user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    fetchUsersAppointment();
    getLoggedInPsychologist(user.uid);
  }

  void fetchUsersAppointment() async {
    final userService = UserService();
    final user = await userService.getUserByUID("userId");
    if (user != null) {
      setState(() {
        users.add(user);
      });
    }
  }

  void getLoggedInPsychologist(String uid) async {
    if (user != null) {
      final psychologistEmail = user!.email;
      if (psychologistEmail != null &&
          psychologistEmail.endsWith('@kmitl.ac.th')) {
        Psychologist? userData =
            await PsychologistService().getPsychologistByUID(uid);
        setState(() {
          loggedInPsychologistName = userData!.firstname;
        });
      }
    } else {
      //back to login page
    }
  }

  void onSelectedUser(Users users) {
    //pop-up detail of user
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => Text('show detail of user'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: Config.baseColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Config.baseColor,
              Config.baseColor,
              Color.fromRGBO(178, 221, 253, 0.2),
              Color.fromRGBO(178, 180, 254, 0.2)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 64,
            left: 32,
            right: 32,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'สวัสดีตอนบ่าย!\n$loggedInPsychologistName',
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
              ),
              SizedBox(height: 30),
              if (users.isNotEmpty)
                UpcomingCard(
                  name: '${users[0].firstname} ${users[0].lastname}',
                  detail: 'konnichiwa, watashino namaewa',
                  dateTime: '12 ส.ค. 2023, 8:00 - 9:00',
                )
              else
                Text('get some rest'),
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
        ),
      ),
    );
  }
}
