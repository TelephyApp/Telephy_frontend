import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telephy/model/appointment.dart';
import 'package:telephy/model/psychologist.dart';
import 'package:telephy/model/users.dart';
import 'package:telephy/pages/message/message_page.dart';
import 'package:telephy/services/appointment_service.dart';
import 'package:telephy/services/psychologist_service.dart';
import 'package:telephy/services/timeslot_service.dart';
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
  Psychologist? psychologist;
  List<Appointment> appointments = [];
  UpcomingCard? upcomCard;
  List<DetailTile> detailTiles = [];

  @override
  void initState() {
    super.initState();
    fetchAppoint();
  }

  Future<void> fetchAppoint() async {
    await fetchPsy();
    await AppointmentService().deleteAppointmentsWithPassedTime();
    await TimeslotService().deleteTimeslotsWithPassedTime();
    appointments = await AppointmentService()
        .getAppointmentsByPsyUid(FirebaseAuth.instance.currentUser!.uid);
    appointments.sort((a, b) => a.startTime.compareTo(b.startTime));
    if (appointments.isNotEmpty) await getUpcomingCard(appointments[0]);
    List<Appointment> sublist = [];
    if (appointments.length > 1) {
      sublist = appointments.sublist(1);
    }
    await getDetailTile(sublist);
  }

  Future<void> fetchPsy() async {
    psychologist = await PsychologistService()
        .getPsychologistByUID(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<void> getUpcomingCard(Appointment appointment) async {
    final Users? upcominguser =
        await UserService().getUserByUID(appointment.userUid);
    final appointmentDate =
        DateFormat('dd MMM yyyy').format(appointment.startTime.toDate());
    final appointmentTime =
        DateFormat('HH:mm').format(appointment.startTime.toDate());
    upcomCard = UpcomingCard(
      name: '${upcominguser!.firstname} ${upcominguser.lastname}',
      detail: upcominguser.medicalCondition != ''
          ? '${upcominguser.medicalCondition}'
          : 'N/A',
      dateTime: DateFormat('dd MMM yyyy, HH:mm').format(
        appointment.startTime.toDate(),
      ),
      onclick: (() =>
          showUserDetail(upcominguser, appointmentDate, appointmentTime)),
    );
  }

  Future<void> getDetailTile(List<Appointment> appointmentList) async {
    List<DetailTile> detailList = [];
    for (int i = 0; i < appointmentList.length; i++) {
      var users = await UserService().getUserByUID(appointmentList[i].userUid);

      DetailTile detailTile = DetailTile(
          name: "${users!.firstname} ${users.lastname}",
          detail: DateFormat('dd MMM yyyy, HH:mm')
              .format(appointmentList[i].startTime.toDate()));
      detailList.add(detailTile);
    }
    detailTiles = detailList;
  }

  void showUserDetail(Users users, date, time) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => Container(
        height: MediaQuery.of(_).size.height * 0.85,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 30,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Information',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Config.darkerToneColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.close_rounded,
                      color: Config.darkerToneColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: Image.asset('assets/images/user.png'),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$date',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        '$time',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        "${users.lastname} ${users.username}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "@${users.username}",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'เพศ: ',
                          style: TextStyle(
                            color: Config.darkerToneColor,
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: users.gender,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'วันเกิด: ',
                              style: TextStyle(
                                color: Config.darkerToneColor,
                                fontSize: 20,
                              ),
                            ),
                            TextSpan(
                              text: users.birthday,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 30),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'อายุ: ',
                              style: TextStyle(
                                color: Config.darkerToneColor,
                                fontSize: 20,
                              ),
                            ),
                            TextSpan(
                              text: '${users.age}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'โรคประจำตัว: ',
                          style: TextStyle(
                            color: Config.darkerToneColor,
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: users.medicalCondition,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1.0,
                      blurRadius: 3.0,
                      offset: Offset(0, 1),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Config.accentColor2,
                      Config.mainColor2,
                    ],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => MessagePage(context: context));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    disabledBackgroundColor: Colors.transparent,
                  ),
                  child: Text(
                    'ส่งข้อความ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
      body: FutureBuilder(
          future: fetchAppoint(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('appointments')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'ยินดีต้อนรับ!\n${psychologist?.firstname ?? ""}',
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
                              if (appointments.isNotEmpty)
                                upcomCard!
                              else
                                Text('get some rest'),
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  itemCount: detailTiles.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        detailTiles[index],
                                        SizedBox(height: 20),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
