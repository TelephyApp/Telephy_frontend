import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telephy/model/psychologist.dart';
import 'package:telephy/model/time_slot.dart';
import 'package:telephy/user_layout.dart';
import 'package:telephy/utils/config.dart';
import 'package:telephy/widgets/psychologist_card.dart';

class confirmBookingScreen extends StatefulWidget {
  const confirmBookingScreen({
    required this.psychologist,
    required this.timeslot,
    super.key,
  });
  final Psychologist psychologist;
  final Timeslot timeslot;

  @override
  State<confirmBookingScreen> createState() => _confirmBookingScreenState();
}

class _confirmBookingScreenState extends State<confirmBookingScreen> {
  void onBackHome() {
    Get.to(
      () => const UserLayout(),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.baseColor,
        elevation: 4,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 12, right: 12, top: 12),
              child: PsychologistCard(
                psychologistName:
                    '${widget.psychologist.firstname} ${widget.psychologist.lastname}',
                workplace: widget.psychologist.hospital,
                ratePerHour: widget.psychologist.ratePerHours,
                setBorderCardBottomLeft: false,
                setBorderCardBottomRight: false,
                backgroundImage: "assets/images/homeuser_bg.png",
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 12, right: 12),
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Config.lighterToneColor,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "เวลานัดหมายของคุณ",
                                style: TextStyle(
                                  fontSize: 16,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 90,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    DateFormat('Hm').format(
                                        widget.timeslot.startTime.toDate()),
                                    style: TextStyle(
                                      fontSize: 16,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    'assets/images/successBooking.png',
                    // height: 200,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    FaIcon(FontAwesomeIcons.heartCircleCheck),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "การนัดหมายของคุณเสร็จสิ้นเรียบร้อยแล้ว",
                      style: TextStyle(
                        fontSize: 16,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 44.0,
                        width: 230,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2.0,
                              blurRadius: 4.0,
                              offset: Offset(0, 2),
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
                          onPressed: onBackHome,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            disabledBackgroundColor: Colors.transparent,
                          ),
                          child: Text(
                            'กลับสู่หน้าหลัก',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
