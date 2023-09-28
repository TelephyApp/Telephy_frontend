import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telephy/utils/config.dart';

class TimeSlotTable extends StatefulWidget {
  final int numberOfHours = 24;
  final int numberOfDaysToShow = 3;
  final DateTime currentDate;
  final List<DateTime> availableSlots;

  const TimeSlotTable({
    Key? key,
    required this.currentDate,
    required this.availableSlots,
  }) : super(key: key);

  @override
  _TimeSlotTableState createState() => _TimeSlotTableState();
}

class _TimeSlotTableState extends State<TimeSlotTable> {
  bool isBooking = false;
  List<List<bool>> isSlotTapped =
      List.generate(3, (dayIndex) => List.generate(24, (hourIndex) => false));
  DateTime? lastCurrentDate;
  DateTime? selectedDateTime;
  DateTime? selectedSlotsTime;
  bool selectSlotsTaped = false;
  @override
  void didUpdateWidget(TimeSlotTable oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.currentDate != lastCurrentDate) {
      for (var dayIndex = 0; dayIndex < isSlotTapped.length; dayIndex++) {
        for (var hourIndex = 0;
            hourIndex < isSlotTapped[dayIndex].length;
            hourIndex++) {
          isSlotTapped[dayIndex][hourIndex] = false;
        }
      }
      lastCurrentDate = widget.currentDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final nextTwoDays = List.generate(
      3,
      (index) => widget.currentDate.add(Duration(days: index)),
    );

    final lastThreeDays = nextTwoDays;

    return Stack(
      children: [
        Container(
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
                  padding: const EdgeInsets.only(
                      left: 90, right: 11, bottom: 11, top: 11),
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
                                  DateFormat('EEE')
                                      .format(lastThreeDays[dayIndex]),
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
                                        : const Color.fromARGB(
                                            0, 254, 254, 254),
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
                          child: TimeSlotTab(
                            hour: hour,
                            isBooking: isBooking,
                          ),
                        ),
                        for (var dayIndex = 0;
                            dayIndex < lastThreeDays.length;
                            dayIndex++)
                          Expanded(
                            child: HourlySlot(
                                day: lastThreeDays[dayIndex],
                                hour: hour,
                                isTapped: isSlotTapped[dayIndex][hourIndex],
                                onTap: () {
                                  if (isBooking && !selectSlotsTaped) {
                                    setState(() {
                                      isSlotTapped[dayIndex][hourIndex] =
                                          !isSlotTapped[dayIndex][hourIndex];
                                      selectSlotsTaped = true;
                                    });
                                  } else if (isBooking &&
                                      selectSlotsTaped &&
                                      isSlotTapped[dayIndex][hourIndex]) {
                                    setState(() {
                                      isSlotTapped[dayIndex][hourIndex] =
                                          !isSlotTapped[dayIndex][hourIndex];
                                      selectSlotsTaped = false;
                                    });
                                  }
                                },
                                selectedSlotsTime: selectedSlotsTime,
                                isBooking: isBooking,
                                setState: (DateTime selectedSlotsTime) {
                                  setState(() {
                                    this.selectedSlotsTime = selectedSlotsTime;
                                  });
                                },
                                availableSlots: widget.availableSlots),
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
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  isBooking = !isBooking;

                  if (isBooking) {
                    selectSlotsTaped = false;
                  }

                  if (!isBooking) {
                    if (selectedSlotsTime != Null) {
                      final selectedDateTimeString =
                          DateFormat('yyyy-MM-dd HH:mm')
                              .format(selectedSlotsTime ?? DateTime.now());
                      print('Selected Slot: $selectedDateTimeString');
                    }
                    isBooking = false;
                    selectSlotsTaped = true;
                    selectedSlotsTime = null;
                    for (var dayIndex = 0;
                        dayIndex < isSlotTapped.length;
                        dayIndex++) {
                      for (var hourIndex = 0;
                          hourIndex < isSlotTapped[dayIndex].length;
                          hourIndex++) {
                        isSlotTapped[dayIndex][hourIndex] = false;
                      }
                    }
                  }
                });
              },
              splashColor: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x500F1B2D),
                      blurRadius: 10,
                      offset: Offset(4, 3),
                    )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                    colors: [Color(0xFF86D2FC), Color(0xFFCCADF9)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Center(
                  child: Icon(
                    isBooking ? Icons.done : Icons.add,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TimeSlotTab extends StatelessWidget {
  final String hour;
  final bool isBooking;

  const TimeSlotTab({Key? key, required this.hour, required this.isBooking})
      : super(key: key);

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
            style: TextStyle(
              fontSize: 16,
              color: isBooking ? Colors.grey : Color(0xFF0F1B2D),
            ),
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
  final DateTime? selectedSlotsTime;
  final bool isBooking;
  final Function(DateTime) setState;
  final List<DateTime>? availableSlots;
  const HourlySlot(
      {Key? key,
      required this.day,
      required this.hour,
      required this.isTapped,
      required this.onTap,
      required this.selectedSlotsTime,
      required this.isBooking,
      required this.setState,
      required this.availableSlots})
      : super(key: key);

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
    bool isInAvailableSlots =
        availableSlots != null && availableSlots!.contains(currentDateTime);
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
                            availableSlots!.remove(currentDateTime);
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
