// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api, must_be_immutable
import 'package:flutter/material.dart';
import 'package:ta_peersupervision/api/repository/event.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  final Function(DateTime, List<MyJadwal>) onDaySelected;
  final Map<DateTime, List<MyJadwal>> jadwal;
  final DateTime focusedDay;

  // Menambahkan inisialisasi langsung pada deklarasi field
  List<MyJadwal> events = [];

  CalendarWidget({super.key, 
    required this.onDaySelected,
    required this.jadwal,
    required this.focusedDay,
  }) {
    // Inisialisasi events di sini
    events = jadwal.values.expand((events) => events).toList();
  }

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
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
            return event.tanggal.year == day.year &&
                event.tanggal.month == day.month &&
                event.tanggal.day == day.day;
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
