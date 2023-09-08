import 'package:flutter/material.dart';
import 'package:telephy/widgets/calender.dart';
import 'package:telephy/widgets/timeSlot.dart';

class TimeSlot extends StatefulWidget {
  const TimeSlot({super.key});

  @override
  State<TimeSlot> createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Calendar(),
          ),
          Expanded(child: TimeSlotTable())
        ],
      ),
    );
  }
}
