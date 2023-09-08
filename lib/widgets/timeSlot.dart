import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late DateTime currentDate = DateTime.now(); // กำหนดค่าเริ่มต้นให้ currentDate

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: TimeSlotTable(currentDate: currentDate), // ส่งค่า currentDate ไปยัง TimeSlotTable
        floatingActionButton: FloatingActionButton( // เพิ่ม FAB สำหรับการอัปเดต currentDate
          onPressed: () {
            setState(() {
              currentDate = DateTime.now(); // อัปเดต currentDate เมื่อกด FAB
            });
          },
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }
}

class TimeSlotTable extends StatelessWidget {
  final int numberOfHours = 24;
  final int numberOfDaysToShow = 3;
  final DateTime currentDate; // รับค่า currentDate จาก MyApp

  TimeSlotTable({required this.currentDate});

  @override
  Widget build(BuildContext context) {
    // ใช้ currentDate ที่รับมาจาก MyApp
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
            height: 80,
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
                  child: SizedBox(width: 20),
                ),
                for (var dayIndex = 0;
                    dayIndex < lastThreeDays.length;
                    dayIndex++)
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
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
                fontWeight: FontWeight.normal,
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
