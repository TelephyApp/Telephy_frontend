import 'package:flutter/material.dart';

class TimeSystemScreen extends StatefulWidget {
  const TimeSystemScreen({super.key});

  @override
  State<TimeSystemScreen> createState() => _TimeSystemScreenState();
}

class _TimeSystemScreenState extends State<TimeSystemScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("timeslot"),
        ],
      ),
    );
  }
}
