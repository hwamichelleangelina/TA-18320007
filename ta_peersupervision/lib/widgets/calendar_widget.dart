import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ta_peersupervision/constants/event.dart';

class CalendarWidget extends StatefulWidget {
  final Function(DateTime, List<Event>) onDaySelected;
  final List<Event> events;
  final DateTime focusedDay;

  const CalendarWidget({super.key, 
    required this.onDaySelected,
    required this.events,
    required this.focusedDay,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0), // Tambahkan margin di sini
      child: TableCalendar(
        calendarFormat: _calendarFormat,
        focusedDay: widget.focusedDay,
        firstDay: DateTime.utc(2000),
        lastDay: DateTime.utc(2100),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
        ),
        eventLoader: (day) {
          return widget.events.where((event) {
            return event.date.year == day.year &&
                event.date.month == day.month &&
                event.date.day == day.day;
          }).toList();
        },
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
          });
          widget.onDaySelected(selectedDay, widget.events);
        },
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            if (events.isNotEmpty) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue[300],
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
