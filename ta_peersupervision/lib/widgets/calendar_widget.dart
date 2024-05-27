// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api, must_be_immutable
import 'package:flutter/material.dart';
import 'package:ta_peersupervision/api/repository/event.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  final Function(DateTime, List<MyJadwal>) onDaySelected;
  final Map<DateTime, List<MyJadwal>> jadwal;
  final DateTime initialFocusedDay;

  CalendarWidget({
    super.key,
    required this.onDaySelected,
    required this.jadwal,
    required this.initialFocusedDay,
  });

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.initialFocusedDay;
    _selectedDay = widget.initialFocusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TableCalendar(
        calendarFormat: _calendarFormat,
        focusedDay: _focusedDay,
        firstDay: DateTime.utc(2000),
        lastDay: DateTime.utc(2100),
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
        ),
        eventLoader: (day) {
          return widget.jadwal[DateTime(day.year, day.month, day.day)] ?? [];
        },
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
          widget.onDaySelected(
            selectedDay,
            widget.jadwal[DateTime(selectedDay.year, selectedDay.month, selectedDay.day)] ?? [],
          );
        },
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            if (events.isNotEmpty) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 241, 100, 246),
                ),
                width: 16.0,
                height: 16.0,
                child: Center(
                  child: Text(
                    '${events.length}',
                    style: const TextStyle().copyWith(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
