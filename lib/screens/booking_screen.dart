import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;

  @override
  Widget build(BuildContext context) {
    const List<String> timeSlots = [
      "19.00 น.",
      "19.30 น.",
      "20.00 น.",
      "20.30 น.",
      "19.00 น."
    ];
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
                    child: Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                              image: DecorationImage(
                                image: AssetImage("assets/images/bg.jpeg"),
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.center,
                                opacity: 0.4,
                              ),
                            ),
                            child: _tableCalendar()),
                        Container(
                          height: 300,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(20),
                            ),
                            color: Config.lighterToneColor,
                          ),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, // Number of columns
                              mainAxisSpacing: 8.0, // Spacing between rows
                              crossAxisSpacing: 8.0, // Spacing between columns
                            ),
                            itemCount:
                              timeSlots.length, // Replace with the number of items you want to display
                            itemBuilder: (context, index) {
                              return GridItem(index);
                            },
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
      rowHeight: 60,
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Config.mainColor2,
          shape: BoxShape.circle,
        ),
        todayTextStyle: TextStyle(color: Config.darkerToneColor),
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

class GridItem extends StatelessWidget {
  final int index;

  GridItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue, // Change the background color as needed
      child: Center(
        child: Text(
          'Item $index',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
