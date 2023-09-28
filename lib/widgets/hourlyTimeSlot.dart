import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telephy/utils/config.dart';
import 'package:telephy/model/time_slot.dart';

class HourlySlot extends StatelessWidget {
  final DateTime day;
  final String hour;
  final bool isTapped;
  final VoidCallback onTap;
  final DateTime? selectedSlotsTime;
  final bool isBooking;
  final Function(DateTime) setState;
  final List<Timeslot> availableTimeslots;
  const HourlySlot({
    Key? key,
    required this.day,
    required this.hour,
    required this.isTapped,
    required this.onTap,
    required this.selectedSlotsTime,
    required this.isBooking,
    required this.setState,
    required this.availableTimeslots,
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
    bool isInAvailableSlots = availableTimeslots != null &&
        availableTimeslots!.any(
            (timeslot) => timeslot.startTime.isAtSameMomentAs(currentDateTime));
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
            onTap: () {
              if (isInAvailableSlots && isBooking) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('ยกเลิกการเปิดจองเวลา'),
                      content: Text(
                          '\t\t\t\tหากยกเลิกแล้วผู้ใช้จะไม่สามารถนัดหมายในช่วงเวลาที่ทำการยกเลิกได้'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            availableTimeslots.removeWhere((timeslot) =>
                                timeslot.startTime
                                    .isAtSameMomentAs(currentDateTime));
                            Navigator.of(context).pop();

                          },
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xFFE4DAD1)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 251, 108, 76))),
                          child: Text('ยกเลิก'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFFB2B4FE)),
                          ),
                          child: Text('ปิด'),
                        )
                      ],
                    );
                  },
                );
              } else {
                if (isBooking) {
                  setState(currentDateTime);
                }
                onTap();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: isInAvailableSlots
                    ? LinearGradient(
                        colors: [
                            Color(0xFF86D2FC),
                            Color(0xFF86D2FC),
                            Color(0xFF868CFD)
                          ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter)
                    : LinearGradient(
                        colors: [
                            Color.fromARGB(110, 254, 254, 254),
                            Color.fromARGB(159, 134, 211, 252)
                          ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter),
                color: isTapped
                    ? const Color.fromRGBO(178, 221, 253, 1)
                    : (isInAvailableSlots
                        ? const Color(0xFF868CFD)
                        : Color.fromARGB(0, 113, 0, 252)),
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