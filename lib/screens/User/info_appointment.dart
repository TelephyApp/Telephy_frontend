import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:telephy/model/psychologist.dart';
import 'package:telephy/screens/User/booking_screen.dart';
import 'package:telephy/services/psychologist_service.dart';
import 'package:telephy/utils/config.dart';
import 'package:telephy/widgets/psychologist_card.dart';
import 'package:get/get.dart';

class InfoAppointment extends StatefulWidget {
  const InfoAppointment({required this.psychologistId, super.key});
  final String psychologistId;

  @override
  State<InfoAppointment> createState() => _InfoAppointmentState();
}

class _InfoAppointmentState extends State<InfoAppointment> {
  // if using MVC , move all of this to LoginController
  Psychologist? psychologist;

  void onAppoint() {
    Get.to(
      () => BookingScreen(
        psychologistId: widget.psychologistId,
      ),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> getPsy() async {
    psychologist =
        await PsychologistService().getPsychologistByUID(widget.psychologistId);
  }

  //-----------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.baseColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Config.darkerToneColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'รายละเอียดนักจิตวิทยา',
          style: TextStyle(
            color: Config.darkerToneColor,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: FutureBuilder(
          future: getPsy(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('psychologists')
                      .doc(widget.psychologistId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SafeArea(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 24, right: 24, left: 24),
                              child: PsychologistCard(
                                imagePath: psychologist!.imagePath,
                                psychologistName:
                                    "${psychologist?.firstname ?? ""} ${psychologist?.lastname ?? ""}",
                                workplace: psychologist?.hospital ?? "",
                                ratePerHour: psychologist?.ratePerHours ?? "",
                                setBorderCardBottomLeft: false,
                                setBorderCardBottomRight: false,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: 24,
                                right: 24,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                color: Config.lighterToneColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 24,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "ภาษา:",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 10),
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 242, 243, 251),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                'ภาษาไทย',
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "คำอธิบาย :",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          height: 100,
                                          width: 300,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Color.fromARGB(
                                                  255, 242, 243, 251)),
                                          child: Text(psychologist!.detail),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: onAppoint,
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        elevation: 3,
                                      ),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Config.accentColor2,
                                              Config.mainColor2,
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          child: Center(
                                            child: Text(
                                              'นัดหมาย',
                                              style: TextStyle(
                                                color: Config.darkerToneColor,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  });
            } else {
              return Config.loadingWidget;
            }
          }),
    );
  }
}
