import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDoctor extends StatefulWidget {
  final void Function(DateTime)
      onDaySelected; // เปลี่ยน data type ของ onDaySelected เป็น void Function(DateTime)

  const CalendarDoctor({Key? key, required this.onDaySelected})
      : super(key: key);

  @override
  State<CalendarDoctor> createState() => _CalendarDoctorState();
}

class _CalendarDoctorState extends State<CalendarDoctor> {
  DateTime today = DateTime.now();
  bool showCalendar = false; // Track whether to show the calendar
  DateTime selectedDay = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });

    widget.onDaySelected(day);
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
                  125.0,
                ),
                topRight: Radius.circular(
                  20.0,
                ),
                bottomLeft: Radius.circular(
                  20.0,
                ),
                bottomRight: Radius.circular(
                  20.0,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 15),
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
                          showCalendar = !showCalendar;
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
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
                              color: Colors.white,
                            ),
                            formatButtonTextStyle: TextStyle(
                              color: Colors.white,
                            ),
                            formatButtonDecoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            leftChevronIcon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 13.0,
                            ),
                            rightChevronIcon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 13.0,
                            ),
                          ),
                          daysOfWeekStyle: const DaysOfWeekStyle(
                            weekdayStyle: TextStyle(
                              color: Color(0xFFB2B4FE),
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
                          ),
                          onDaySelected: _onDaySelected,
                          calendarStyle: const CalendarStyle(
                            defaultTextStyle: TextStyle(
                              color: Colors.white,
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
                              color: Color(0xFFB2B4FE),
                              shape: BoxShape.circle,
                            ),
                          ),
                          calendarBuilders: CalendarBuilders(
                            selectedBuilder: (context, date, _) {
                              return Container(
                                margin: const EdgeInsets.all(0.25),
                                width: 50,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Text(
                                  '${date.day}',
                                  style: const TextStyle(
                                    color: Color(0xFF0F1B2D),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
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
