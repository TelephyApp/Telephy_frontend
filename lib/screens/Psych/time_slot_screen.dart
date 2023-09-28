// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:telephy/widgets/calender.dart';
import 'package:telephy/widgets/timeSlotTable.dart';



class TimeSlotScreen extends StatefulWidget {
  const TimeSlotScreen({Key? key}) : super(key: key);

  @override
  _TimeSlotScreenState createState() => _TimeSlotScreenState();
}

class _TimeSlotScreenState extends State<TimeSlotScreen> {
  DateTime selectedDay = DateTime.now();
  List<DateTime> availableSlots = [
    DateTime(2023, 9, 29, 1, 0),
    DateTime(2023, 9, 30, 5, 0),
  ];
  
  @override
  Widget build(BuildContext context) {
    print(availableSlots);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: CalendarDoctor(onDaySelected: (day) {
                  setState(() {
                    selectedDay = day;
                  });
                }),
              ),
              Expanded(
                child: TimeSlotTable(
                    currentDate: selectedDay, availableSlots: availableSlots),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
