import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:telephy/utils/config.dart';
import 'package:telephy/widgets/psychologist_card.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  CalendarFormat _format = CalendarFormat.week;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  // ignore: unused_field
  int? _currentIndex;
  // ignore: unused_field
  bool _isWeekend = false;
  // ignore: unused_field
  bool _dateSelected = false;
  // ignore: unused_field
  bool _timeSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            color: Config.darkerToneColor,
          ),
        ),
        leadingWidth: 60,
        titleSpacing: -10,
        title: Text(
          "นัดพบจิตแพทย์",
          style: TextStyle(
            fontSize: 25,
            color: Config.darkerToneColor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  PhychologistCard(
                    psychologistName: "อัมรี ฮ้วง",
                    workplace: "ลาดบัง",
                    ratePerHour: "4000",
                    imagePath: "assets/images/erum.png",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        _tableCalendar(),
                        Container(
                          height: 200,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20)),
                            color: Config.mainColor2,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableCalendar() {
    return TableCalendar(
      headerStyle: const HeaderStyle(
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        formatButtonVisible: false, // Hide the month selection button
      ),
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(2023, 12, 31),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Config.mainColor2,
          shape: BoxShape.circle,
        ),
      ),
      availableCalendarFormats: const {
        CalendarFormat.week: 'Week',
      },
      onFormatChanged: (format) {
        setState(() {
          _format = format;
        });
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _currentDay = selectedDay;
          _focusDay = focusedDay;
          _dateSelected = true;
          if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
            _isWeekend = true;
            _timeSelected = false;
            _currentIndex = null;
          } else {
            _isWeekend = false;
          }
        });
      },
    );
  }
}
