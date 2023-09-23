import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:telephy/model/time_slot.dart';
import 'package:telephy/services/timeslot_service.dart';
import 'package:telephy/utils/config.dart';
import 'package:telephy/widgets/psychologist_card.dart';
import 'package:telephy/widgets/timeSlot.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({required this.phychologistName, super.key});
  final String phychologistName;
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  CalendarFormat _format = CalendarFormat.week;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  List<Timeslot> selectedDayTimeSlots = [];
  List<Timeslot> timeslots = [];

  @override
  void initState() {
    super.initState();
    fetchAllTimeslots();
    selectedDayTimeSlots = timeslots.where((timeSlot) {
      return timeSlot.startTime.year == DateTime.now().year &&
          timeSlot.startTime.month == DateTime.now().month &&
          timeSlot.startTime.day == DateTime.now().day;
    }).toList();
  }

  void fetchAllTimeslots() async {
    timeslots = await TimeslotService().getAllTimeSlots();
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PsychologistCard(
                      psychologistName: widget.phychologistName,
                      workplace: "ลาดบัง",
                      ratePerHour: "4000",
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
                                image: AssetImage("assets/images/bg.jpeg"),
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
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                padding: EdgeInsets.all(10),
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount:
                                              3, // Set the number of columns to 3
                                          crossAxisSpacing:
                                              8.0, // Add horizontal spacing between items
                                          mainAxisSpacing:
                                              8.0, // Add vertical spacing between items
                                          childAspectRatio: (1 / .4)),
                                  itemCount: selectedDayTimeSlots.length,
                                  shrinkWrap: true,
                                  physics:
                                      NeverScrollableScrollPhysics(), // Disable scrolling for the GridView
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        setState(() {
                                          _currentIndex = index;
                                          _timeSelected = true;
                                        });
                                      },
                                      child: AspectRatio(
                                        aspectRatio: 0.4,
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: _currentIndex == index
                                                ? Config.mainColor1
                                                : Config.lighterToneColor,
                                            border: Border.all(
                                              color: Colors.black26,
                                              width: 1.0,
                                            ),
                                          ),
                                          child: Text(
                                            '${selectedDayTimeSlots[index].startTime.toString()}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: _currentIndex == index
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                height: 44.0,
                                width: 230,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(
                                          0.2), // Shadow color and opacity
                                      spreadRadius: 2.0, // Spread radius
                                      blurRadius: 4.0, // Blur radius
                                      offset: Offset(0,
                                          2), // Shadow offset (horizontal, vertical)
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
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: Text(
                                    'ยืนยันการนัดหมาย',
                                    style: TextStyle(color: Colors.white),
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
      ),
    );
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
          List<Timeslot> selectedDayTimeSlots = timeslots.where((timeSlot) {
            // Check if the start time of the time slot matches the selected date
            return timeSlot.startTime.year == selectedDay.year &&
                timeSlot.startTime.month == selectedDay.month &&
                timeSlot.startTime.day == selectedDay.day;
          }).toList();
          _currentDay = selectedDay;
          _focusDay = focusedDay;
          _dateSelected = true;
          if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
            _isWeekend = true;
            _timeSelected = false;
            _currentIndex = null;
          } else {
            _isWeekend = false;
          }
        });
      },
    );
  }
}
