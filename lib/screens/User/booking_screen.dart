import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:telephy/model/psychologist.dart';
import 'package:telephy/model/time_slot.dart';
import 'package:telephy/screens/User/payment_screen.dart';
import 'package:telephy/services/psychologist_service.dart';
import 'package:telephy/services/timeslot_service.dart';
import 'package:telephy/utils/config.dart';
import 'package:telephy/widgets/psychologist_card.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({required this.psychologistId, super.key});
  final String psychologistId;
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  CalendarFormat _format = CalendarFormat.week;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  List<Timeslot> _selectedDayTimeSlots = [];
  List<Timeslot> timeslots = [];
  Psychologist? psychologist;

  @override
  void initState() {
    fetchPsy();
    fetchTimeslots();
    super.initState();
    _selectedDayTimeSlots = timeslots.where((timeSlot) {
      return timeSlot.startTime.toDate().year == DateTime.now().year &&
          timeSlot.startTime.toDate().month == DateTime.now().month &&
          timeSlot.startTime.toDate().day == DateTime.now().day;
    }).toList();
  }

  Future<void> fetchPsy() async {
    psychologist =
        await PsychologistService().getPsychologistByUID(widget.psychologistId);
    fetchTimeslots();
  }

  Future<List<Timeslot>> fetchTimeslots() async {
    timeslots =
        await TimeslotService().getAllTimeSlotsByPsyId(widget.psychologistId);
    return await TimeslotService()
        .getAllTimeSlotsByPsyId(widget.psychologistId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Config.darkerToneColor,
            ),
          ),
          leadingWidth: 60,
          titleSpacing: -10,
          title: const Text(
            "นัดพบจิตแพทย์",
            style: TextStyle(
              fontSize: 25,
              color: Config.darkerToneColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('psychologists')
                .doc(widget.psychologistId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PsychologistCard(
                                imagePath: psychologist!.imagePath,
                                psychologistName:
                                    "${psychologist!.firstname} ${psychologist!.lastname}",
                                workplace: psychologist!.hospital,
                                ratePerHour: psychologist!.ratePerHours,
                                // imagePath: "assets/images/erum.png",
                                setBorderCardBottomLeft: true,
                                setBorderCardBottomRight: true,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/homeuser_bg.png"),
                                          fit: BoxFit.fitWidth,
                                          alignment: Alignment.center,
                                          opacity: 0.4,
                                        ),
                                      ),
                                      child: _tableCalendar()),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(20),
                                      ),
                                      color: Config.lighterToneColor,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                vertical: 5,
                                                horizontal: 10,
                                              ),
                                              child: Text(
                                                "เลือกช่วงเวลาที่ต้องการเข้าพบ",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        _selectedDayTimeSlots.isEmpty
                                            ? Container(
                                                height: 100,
                                                child: Center(
                                                  child:
                                                      Text("ยังไม่มีเวลาเปิด"),
                                                ),
                                              )
                                            : Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                padding: EdgeInsets.all(10),
                                                child:
                                                    FutureBuilder<
                                                            List<Timeslot>>(
                                                        future:
                                                            fetchTimeslots(),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .done) {
                                                            return StreamBuilder<
                                                                    QuerySnapshot>(
                                                                stream: FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "timeslots")
                                                                    .snapshots(),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  return GridView
                                                                      .builder(
                                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                        crossAxisCount: 3, // Set the number of columns to 3
                                                                        crossAxisSpacing: 8.0, // Add horizontal spacing between items
                                                                        mainAxisSpacing: 8.0, // Add vertical spacing between items
                                                                        childAspectRatio: (1 / .4)),
                                                                    itemCount:
                                                                        _selectedDayTimeSlots
                                                                            .length,
                                                                    shrinkWrap:
                                                                        true,
                                                                    physics:
                                                                        NeverScrollableScrollPhysics(), // Disable scrolling for the GridView
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            _currentIndex =
                                                                                index;
                                                                          });
                                                                        },
                                                                        child:
                                                                            AspectRatio(
                                                                          aspectRatio:
                                                                              0.4,
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.all(8),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                              color: _currentIndex == index ? Config.mainColor1 : Config.lighterToneColor,
                                                                              border: Border.all(
                                                                                color: Colors.black26,
                                                                                width: 1.0,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              DateFormat('Hm').format(_selectedDayTimeSlots[index].startTime.toDate()),
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: _currentIndex == index ? Colors.white : Colors.black,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                });
                                                          } else {
                                                            return Center(
                                                              child: Config
                                                                  .loadingWidget,
                                                            );
                                                          }
                                                        }),
                                              ),
                                        Container(
                                          height: 44.0,
                                          width: 230,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                    0.2), // Shadow color and opacity
                                                spreadRadius:
                                                    2.0, // Spread radius
                                                blurRadius: 4.0, // Blur radius
                                                offset: Offset(0,
                                                    2), // Shadow offset (horizontal, vertical)
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(50),
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
                                            onPressed: _currentIndex == null
                                                ? null
                                                : () async {
                                                    Get.to(
                                                      () => PaymentScreen(
                                                        psychologist:
                                                            psychologist!,
                                                        timeslot:
                                                            _selectedDayTimeSlots[
                                                                _currentIndex!],
                                                      ),
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.easeInOut,
                                                    );
                                                  },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.transparent,
                                              shadowColor: Colors.transparent,
                                              disabledBackgroundColor:
                                                  Colors.transparent,
                                            ),
                                            child: Text(
                                              'ยืนยันการนัดหมาย',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  Widget _tableCalendar() {
    return TableCalendar(
      headerStyle: const HeaderStyle(
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        formatButtonVisible: false, // Hide the month selection button
      ),
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(2023, 12, 31),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 60,
      calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Config.mainColor2,
            shape: BoxShape.circle,
          ),
          todayTextStyle: TextStyle(color: Config.darkerToneColor),
          weekendTextStyle: TextStyle(color: Config.darkerToneColor)),
      daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: Config.darkerToneColor),
          weekendStyle: TextStyle(color: Config.darkerToneColor)),
      availableCalendarFormats: const {
        CalendarFormat.week: 'Week',
      },
      onFormatChanged: (format) {
        setState(() {
          _format = format;
        });
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          fetchPsy();
          List<Timeslot> selectedDayTimeSlots = timeslots.where((timeSlot) {
            // Check if the start time of the time slot matches the selected date
            return timeSlot.startTime.toDate().year == selectedDay.year &&
                timeSlot.startTime.toDate().month == selectedDay.month &&
                timeSlot.startTime.toDate().day == selectedDay.day;
          }).toList();
          _selectedDayTimeSlots = selectedDayTimeSlots;
          _currentDay = selectedDay;
          _focusDay = focusedDay;
        });
      },
    );
  }
}
