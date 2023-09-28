// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:telephy/model/time_slot.dart';
import 'package:telephy/widgets/calender.dart';
import 'package:telephy/widgets/timeSlotTable.dart';

class TimeSlotScreen extends StatefulWidget {
  const TimeSlotScreen({Key? key}) : super(key: key);

  @override
  _TimeSlotScreenState createState() => _TimeSlotScreenState();
}

class _TimeSlotScreenState extends State<TimeSlotScreen> {
  DateTime selectedDay = DateTime.now();
  List<Timeslot> availableTimeslots = [
    Timeslot(id: "101", psyId: "aot", startTime: DateTime(2023, 9, 29, 1, 0)),
    Timeslot(id: "102", psyId: "Miss", startTime: DateTime(2023, 9, 30, 2, 0)),
    Timeslot(id: "103", psyId: "Nep", startTime: DateTime(2023, 10, 1, 5, 0)),
    Timeslot(id: "104", psyId: "Jem", startTime: DateTime(2023, 10, 1, 2, 0))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: CalendarDoctor(
                    onDaySelected: (day) {
                      setState(() {
                        selectedDay = day;
                      });
                    },
                    availableTimeslots: availableTimeslots),
              ),
              Expanded(
                child: TimeSlotTable(
                    currentDate: selectedDay,
                    availableTimeslots: availableTimeslots,
                    setTimeslotsState: (availableTimeslots) {
                      setState(() {
                        this.availableTimeslots = availableTimeslots;
                      });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
