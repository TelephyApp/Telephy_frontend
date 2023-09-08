import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: TimeSlotTable(),
      ),
    );
  }
}

class TimeSlotTable extends StatelessWidget {
  final int numberOfHours = 24;
  final int numberOfDaysToShow = 3;

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final nextTwoDays = List.generate(
      3,
      (index) => currentDate.add(Duration(days: index)),
    );

    final lastThreeDays = nextTwoDays.reversed.toList();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFEFEFE), Color(0xFFDDDEFC)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 110,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                colors: [Color(0xFFB2DDFD), Color(0xFFB2B4FE)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(width: 50),
                ),
                for (var dayIndex = 0;
                    dayIndex < lastThreeDays.length;
                    dayIndex++)
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            DateFormat('EEE').format(lastThreeDays[dayIndex]),
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF0F1B2D),
                            ),
                          ),
                          Text(
                            DateFormat('dd').format(lastThreeDays[dayIndex]),
                            style: TextStyle(
                              fontSize: 28,
                              color: Color(0xFF0F1B2D),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: numberOfHours,
              itemBuilder: (BuildContext context, int hourIndex) {
                final hour = hourIndex.toString().padLeft(2, '0');
                return Row(
                  children: [
                    Expanded(
                      child: TimeSlot(hour: hour),
                    ),
                    for (var dayIndex = 0;
                        dayIndex < lastThreeDays.length;
                        dayIndex++)
                      Expanded(
                        child: HourlySlot(
                          day: lastThreeDays[dayIndex],
                          hour: hour,
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class TimeSlot extends StatelessWidget {
  final String hour;

  TimeSlot({required this.hour});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            '$hour:00',
            style: TextStyle(fontSize: 16, color: Color(0xFF0F1B2D)),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class HourlySlot extends StatefulWidget {
  final DateTime day;
  final String hour;

  HourlySlot({required this.day, required this.hour});

  @override
  _HourlySlotState createState() => _HourlySlotState();
}

class _HourlySlotState extends State<HourlySlot> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isTapped = !isTapped;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isTapped
              ? Color.fromRGBO(178, 221, 253, 1)
              : Color.fromARGB(0, 209, 172, 255),
          border: Border.all(
            color: isTapped ? Color(0xFFE4DAD1) : Color(0xFFD2ACFF),
            width: 0.5,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              " ",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
