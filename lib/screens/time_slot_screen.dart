import 'package:flutter/material.dart';
import 'package:telephy/widgets/calender.dart';
import 'package:telephy/widgets/timeSlot.dart';

class TimeSlot extends StatefulWidget {
  const TimeSlot({Key? key}) : super(key: key);

  @override
  _TimeSlotState createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot> {
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Calendar(),
          ),
          Expanded(
            child: TimeSlotTable(
                currentDate:
                    currentDate), // ส่งค่า currentDate ไปยัง TimeSlotTable
          ),
        ],
      ),
    );
  }
}
