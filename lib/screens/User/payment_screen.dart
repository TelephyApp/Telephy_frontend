import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telephy/model/appointment.dart';
import 'package:telephy/model/psychologist.dart';
import 'package:telephy/model/time_slot.dart';
import 'package:telephy/screens/User/confirmBooking_screen.dart';
import 'package:telephy/screens/User/home_screen.dart';
import 'package:telephy/screens/User/user_home_screen.dart';
import 'package:telephy/services/appointment_service.dart';
import 'package:telephy/services/chat_service.dart';
import 'package:telephy/services/psychologist_service.dart';
import 'package:telephy/utils/config.dart';
import 'package:telephy/widgets/psychologist_card.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    required this.psychologist,
    required this.timeslot,
    super.key,
  });

  final Psychologist psychologist;
  final Timeslot timeslot;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  void toConfirmBooking() {
    addAppointmentByTimeslot();
    Get.to(
      () => confirmBookingScreen(
          psychologist: widget.psychologist, timeslot: widget.timeslot),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void addAppointmentByTimeslot() async {
    var psyId = await PsychologistService()
        .getPsychologistUidByObject(widget.psychologist);
    await AppointmentService()
        .addAppointment(widget.timeslot, FirebaseAuth.instance.currentUser?.uid)
        .then((value) => ChatService()
            .createChatRoom(psyId!, FirebaseAuth.instance.currentUser!.uid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.baseColor,
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
          'ชำระเงิน',
          style: TextStyle(
            color: Config.darkerToneColor,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
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
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              height: 210,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Config.lighterToneColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 32,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ชื่อบัญชี',
                          style: TextStyle(
                            color: Config.darkerToneColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Telephy Co., Ltd.',
                          style: TextStyle(
                            color: Config.darkerToneColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ธนาคาร',
                          style: TextStyle(
                            color: Config.darkerToneColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'กรุงไทย',
                          style: TextStyle(
                            color: Config.darkerToneColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            final String textToCopy = '086-0-72063-2';
                            Clipboard.setData(ClipboardData(text: textToCopy));
                          },
                          child: Row(
                            children: [
                              Text(
                                'เลขที่บัญชี',
                                style: TextStyle(
                                  color: Config.darkerToneColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.copy,
                                color: Colors.black,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '086-0-72063-2',
                          style: TextStyle(
                            color: Config.darkerToneColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 30,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ยอดชำระ',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '฿ 350.00',
                        style: TextStyle(
                          color: Config.darkerToneColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'VAT (7%)',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '฿ 24.50',
                        style: TextStyle(
                          color: Config.darkerToneColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ยอดชำระเงินทั้งหมด',
                        style: TextStyle(
                          color: Config.darkerToneColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '฿ 374.50',
                        style: new TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          foreground: Paint()
                            ..shader = LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Config.accentColor2,
                                Config.mainColor2,
                              ],
                            ).createShader(
                              Rect.fromLTWH(0, 0, 200, 70),
                            ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 44.0,
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
                    border: Border.all(
                      width: 2,
                      color: Colors.transparent,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        disabledBackgroundColor: Colors.transparent,
                      ),
                      child: Text(
                        'อัปโหลด',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 44.0,
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
                    onPressed: toConfirmBooking,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      disabledBackgroundColor: Colors.transparent,
                    ),
                    child: Text(
                      'ยืนยันการชำระเงิน',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
