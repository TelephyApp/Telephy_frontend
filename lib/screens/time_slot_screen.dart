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
      //check button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isBooking = !isBooking;
          });
        },
        child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFD2ACFF),
                  Color(0xFFD2ACFF),
                  Color(0xFFADBDFA),
                  Color(0xFFB2DDFD)
                ], // Adjust the gradient colors
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: isBooking
                ? const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                  )),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CalendarDoctor(onDaySelected: (day) {
                setState(() {
                  selectedDay = day;
                });
              }),
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
