import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telephy/utils/config.dart';

class TimeSlotTable extends StatefulWidget {
  final int numberOfHours = 24;
  final int numberOfDaysToShow = 3;
  final DateTime currentDate;

  const TimeSlotTable({Key? key, required this.currentDate}) : super(key: key);

  @override
  _TimeSlotTableState createState() => _TimeSlotTableState();
}

class _TimeSlotTableState extends State<TimeSlotTable> {
  bool isBooking = false; // Added state variable
  List<List<bool>> isSlotTapped = List.generate(
      3,
      (dayIndex) =>
          List.generate(24, (hourIndex) => false)); // Slot tapped state

  @override
  Widget build(BuildContext context) {
    final nextTwoDays = List.generate(
      3,
      (index) => widget.currentDate.add(Duration(days: index)),
    );

    final lastThreeDays = nextTwoDays;

    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFEFEFE), Color(0xFFFEFEFE), Color(0xFFDDDEFC)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF0F1B2D), width: 0),
              color: Config.darkerToneColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(11),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 129, 129, 129),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  )
                ],
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                  colors: [Color(0xFFB2DDFD), Color(0xFFB2B4FE)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: SizedBox(
                      width: 20,
                    ),
                  ),
                  for (var dayIndex = 0;
                      dayIndex < lastThreeDays.length;
                      dayIndex++)
                    Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              DateFormat('EEE').format(lastThreeDays[dayIndex]),
                              style: TextStyle(
                                fontSize: 12,
                                color: dayIndex == 0
                                    ? const Color(0xFFFEFEFE)
                                    : const Color(0xFF0F1B2D),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: dayIndex == 0
                                    ? const Color(0xFF0F1B2D)
                                    : const Color.fromARGB(0, 254, 254, 254),
                              ),
                              child: Center(
                                child: Text(
                                  DateFormat('dd')
                                      .format(lastThreeDays[dayIndex]),
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: dayIndex == 0
                                        ? const Color(0xFFFEFEFE)
                                        : const Color(0xFF0F1B2D),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.numberOfHours,
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
                          isTapped: isSlotTapped[dayIndex]
                              [hourIndex], // Pass tapped state
                          onTap: () {
                            // Toggle tapped state for this specific day and hour
                            setState(() {
                              isSlotTapped[dayIndex][hourIndex] =
                                  !isSlotTapped[dayIndex][hourIndex];
                            });
                          },
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class TimeSlot extends StatelessWidget {
  final String hour;

  const TimeSlot({Key? key, required this.hour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            '$hour:00',
            style: const TextStyle(fontSize: 16, color: Color(0xFF0F1B2D)),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class HourlySlot extends StatelessWidget {
  final DateTime day;
  final String hour;
  final bool isTapped;
  final VoidCallback onTap;

  const HourlySlot({
    Key? key,
    required this.day,
    required this.hour,
    required this.isTapped,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime currentTime = DateTime.now();
    final DateTime currentDateTime = DateTime(
      day.year,
      day.month,
      day.day,
      int.parse(hour),
    );

    String generateTimeRange(int hour) {
      final startHour = hour;
      final endHour = (hour + 1) % 24;

      return '${startHour.toString().padLeft(2, '0')}:00-${endHour.toString().padLeft(2, '0')}:00';
    }

    String timeRange = generateTimeRange(int.parse(hour));

    final bool isPastDay = currentDateTime.isBefore(currentTime);

    return isPastDay
        ? Container(
            decoration: BoxDecoration(
              color: const Color(0xFFDDDEFC),
              border: Border.all(
                color: const Color(0xFFD2ACFF),
                width: 0.5,
              ),
            ),
            child: const Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  '',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          )
        : GestureDetector(
            onTap: onTap, // Use onTap function passed from parent
            child: Container(
              decoration: BoxDecoration(
                color: isTapped
                    ? const Color.fromRGBO(178, 221, 253, 1)
                    : const Color.fromARGB(0, 209, 172, 255),
                border: Border.all(
                  color: isTapped
                      ? const Color(0xFFE4DAD1)
                      : const Color(0xFFD2ACFF),
                  width: 0.5,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    isTapped
                        ? '${DateFormat('EEE').format(day)} $timeRange'
                        : " ",
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          );
  }
}
