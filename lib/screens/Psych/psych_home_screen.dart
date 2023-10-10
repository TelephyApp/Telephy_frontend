import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:telephy/model/appointment.dart';
import 'package:telephy/model/psychologist.dart';
import 'package:telephy/model/users.dart';
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
    await getDetailTile(appointments);
  }

  Future<void> fetchPsy() async {
    psychologist = await PsychologistService()
        .getPsychologistByUID(FirebaseAuth.instance.currentUser!.uid);
  }

  void showUserDetail(Users users) {
    //pop-up detail of user
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'New Transaction',
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
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close_rounded,
                      color: Config.darkerToneColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.9,
                child: GestureDetector(
                  onTap: () {
                    try {
                      Navigator.of(context).pop();
                    } catch (e) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Config.accentColor1,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'SAVE',
                      style: TextStyle(
                        color: Config.backgroundColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
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

  Future<void> getUpcomingCard(Appointment appointment) async {
    final Users? upcominguser =
        await UserService().getUserByUID(appointment.userUid);
    upcomCard = UpcomingCard(
      name: '${upcominguser!.firstname} ${upcominguser.lastname}',
      detail: 'konnichiwa, watashino namaewa',
      dateTime:
          DateFormat('yyyy-MM-dd HH:mm').format(appointment.startTime.toDate()),
    );
  }

  Future<void> getDetailTile(List<Appointment> appointmentList) async {
    for (int i = 0; i < appointmentList.length; i++) {
      var users = await UserService().getUserByUID(appointmentList[i].userUid);
      var detailTile = DetailTile(
        name: "${users!.firstname} ${users.lastname}",
        detail: "detail",
        onclick: (() => showUserDetail(users)),
      );
      detailTiles.add(detailTile);
    }
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
                                      'สวัสดีตอนบ่าย!\n${psychologist?.firstname ?? ""}',
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
                                  itemCount: appointments.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        SizedBox(height: 20),
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
