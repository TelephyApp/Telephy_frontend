// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime today = DateTime.now();
  bool showCalendar = false; // Track whether to show the calendar

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Content(),
    );
  }

  Widget Content() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0xFF40496C),
                  Color(0xFF142033),
                  Color(0xFF0F1B2D),
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                    125.0), // Top-left corner with a radius of 150
                topRight: Radius.circular(
                    20.0), // Top-right corner with a radius of 20
                bottomLeft: Radius.circular(
                    20.0), // Bottom-left corner with a radius of 20
                bottomRight: Radius.circular(
                    20.0), // Bottom-right corner with a radius of 20
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 54.0, bottom: 20.0),
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      'โปรดเลือกเวลาที่ต้องการ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          showCalendar =
                              !showCalendar; // Toggle the calendar visibility
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize
                            .min, // Use MainAxisSize.min to make the row as narrow as possible
                        children: [
                          Text(
                            DateFormat.MMMMd().format(today),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Icon(
                            showCalendar
                                ? Icons.arrow_drop_up_rounded
                                : Icons.arrow_drop_down_rounded,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      // Conditionally show the calendar
                      visible: showCalendar,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                        child: TableCalendar(
                          locale: "en_US",
                          rowHeight: 29,
                          headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                            titleTextStyle: TextStyle(
                              color: Colors.white, // Set the month text color
                            ),
                            formatButtonTextStyle: TextStyle(
                              color: Colors
                                  .white, // Set the format button text color
                            ),
                            formatButtonDecoration: BoxDecoration(
                              color: Colors
                                  .transparent, // Make the format button background transparent
                            ),
                            leftChevronIcon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors
                                  .white, // Set the left arrow button color
                              size: 15.0,
                            ),
                            rightChevronIcon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors
                                  .white, // Set the right arrow button color
                              size: 15.0,
                            ),
                          ),
                          daysOfWeekStyle: const DaysOfWeekStyle(
                            weekdayStyle: TextStyle(
                              color: Color(
                                  0xFFB2B4FE), // Set the weekday text color
                            ),
                            weekendStyle: TextStyle(
                              color: Color(0xFFB2B4FE),
                            ),
                          ),
                          firstDay: DateTime.utc(1950, 1, 1),
                          lastDay: DateTime.utc(2100, 12, 31),
                          focusedDay: today,
                          selectedDayPredicate: (day) => isSameDay(
                            day,
                            today,
                          ), // Highlight the selected day
                          onDaySelected: _onDaySelected,
                          calendarStyle: const CalendarStyle(
                            defaultTextStyle: TextStyle(
                              color: Colors
                                  .white, // Set the text style for the day cells to white
                            ),
                            weekendTextStyle: TextStyle(
                              color: Colors.white,
                            ),
                            outsideTextStyle: TextStyle(
                              color: Color(0xFFE4DAD1),
                            ),
                            todayTextStyle: TextStyle(color: Colors.white),
                            selectedTextStyle: TextStyle(
                              color: Color(0xFF0F1B2D),
                            ),
                            todayDecoration: BoxDecoration(
                              color: Color(
                                  0xFFB2B4FE), // Change the color as desired
                              shape: BoxShape.circle,
                            ),
                          ),
                          calendarBuilders: CalendarBuilders(
                              selectedBuilder: (context, date, _) {
                            // Customize the appearance of the selected date here
                            return Container(
                              margin: const EdgeInsets.all(0.25),
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    Colors.white, // Change the color as desired
                              ),
                              child: Text(
                                '${date.day}',
                                style: const TextStyle(
                                  color: Color(
                                      0xFF0F1B2D), // Change the text color as desired
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
