import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:telephy/model/appointment.dart';
import 'package:telephy/model/psychologist.dart';
import 'package:telephy/model/time_slot.dart';
import 'package:telephy/utils/config.dart';
import 'package:telephy/widgets/psychologist_card.dart';

class confirmBookingScreen extends StatefulWidget {
  const confirmBookingScreen({required this.psychologist,required this.timeslot,super.key});
  final Psychologist psychologist;
  final Timeslot timeslot;
  @override
  State<confirmBookingScreen> createState() => _confirmBookingScreenState();
}

class _confirmBookingScreenState extends State<confirmBookingScreen> {
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
            PsychologistCard(
              psychologistName: '${widget.psychologist.firstname} ${widget.psychologist.lastname}',
              workplace: widget.psychologist.hospital,
              ratePerHour: widget.psychologist.ratePerHours,
              setBorderCardBottomLeft: false,
              setBorderCardBottomRight: false,
            ),
            Container(
              margin: EdgeInsets.only(left: 24, right: 24),
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
                                    widget.timeslot.startTime.toString(),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
