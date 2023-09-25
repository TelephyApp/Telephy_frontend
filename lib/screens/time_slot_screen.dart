// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:telephy/widgets/calender.dart';
import 'package:telephy/widgets/timeSlot.dart';

class TimeSlotScreen extends StatefulWidget {
  const TimeSlotScreen({Key? key}) : super(key: key);

  @override
  _TimeSlotScreenState createState() => _TimeSlotScreenState();
}

class _TimeSlotScreenState extends State<TimeSlotScreen> {
  DateTime selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Text('data'),
              // Text('data2'),

              // CalendarDoctor(onDaySelected: (day) {
              //   setState(() {
              //     selectedDay = day;
              //   });
              // }),

              // TimeSlotTable(currentDate: selectedDay),

              Container(
                child: CalendarDoctor(onDaySelected: (day) {
                  setState(() {
                    selectedDay = day;
                  });
                }),
              ),
              Expanded(
                child: TimeSlotTable(currentDate: selectedDay),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
