import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TimeslotDoctor extends StatefulWidget {
  const TimeslotDoctor({super.key});

  @override
  _TimeslotDoctorState createState() => _TimeslotDoctorState();
}

class _TimeslotDoctorState extends State<TimeslotDoctor> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 2));
  final Color lighter_Tone = Color(0xFFDDDEFC);
  final Color base_Colour = Color(0xFFFEFEFE);
  final Color darker_Tone = Color(0xFF0F1B2D);
  final Color main_color1 = Color(0xFFB2B4FE);
  final Color accent_colour = Color(0xFFD2ACFF);

  List<Appointment> appointments = [];
  DateTime? selectedDate;
  List<TimeRegion> regions = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            base_Colour,
            base_Colour,
            lighter_Tone,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: SfCalendar(
        view: CalendarView.week,
        viewHeaderHeight: 80,
        timeSlotViewSettings: TimeSlotViewSettings(
          timeIntervalWidth: 300,
          timeIntervalHeight: 50,
          timeFormat: 'H:mm',
          startHour: 7,
          endHour: 0,
          timeRulerSize: 70,
          timeTextStyle: TextStyle(fontSize: 15, color: darker_Tone),
        ),
        onTap: (CalendarTapDetails details) {
          if (details.targetElement == CalendarElement.calendarCell) {
            setState(() {
              selectedDate = details.date;

              final timeRegion = TimeRegion(
                startTime: details.date!,
                endTime: details.date!.add(Duration(hours: 1)),
                enablePointerInteraction: false,
                color: main_color1,
                text: 'Break',
              );
              regions.add(timeRegion);
            });
          }
        },
        viewHeaderStyle: ViewHeaderStyle(
          dayTextStyle: TextStyle(
            color: darker_Tone,
            fontSize: 10,
          ),
          dateTextStyle: TextStyle(
            color: darker_Tone,
            fontSize: 25,
          ),
          backgroundColor: main_color1,
        ),
        todayHighlightColor: darker_Tone,
        todayTextStyle: TextStyle(
          color: base_Colour,
          fontSize: 20,
        ),
        specialRegions: regions,
        cellBorderColor: accent_colour,
      ),
    );
  }
}
