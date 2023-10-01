// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:telephy/model/time_slot.dart';
import 'package:telephy/services/timeslot_service.dart';
import 'package:telephy/widgets/calender.dart';
import 'package:telephy/widgets/timeSlotTable.dart';

class TimeSlotScreen extends StatefulWidget {
  const TimeSlotScreen({Key? key}) : super(key: key);

  @override
  _TimeSlotScreenState createState() => _TimeSlotScreenState();
}

class _TimeSlotScreenState extends State<TimeSlotScreen> {
  DateTime selectedDay = DateTime.now();
  List<Timeslot> availableTimeslots = [];

  Future<void> fetchAllTimeslot() async {
    availableTimeslots = await TimeslotService().getAllTimeSlots();
  }

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
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: fetchAllTimeslot(),
                    builder: (context, snapshot) {
                      return StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('timeslots')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return TimeSlotTable(
                                  currentDate: selectedDay,
                                availableTimeslots: availableTimeslots!,
                                  setTimeslotsState: (availableTimeslots) {
                                    setState(() {
                                      this.availableTimeslots =
                                          availableTimeslots;
                                    });
                                  });
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
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
