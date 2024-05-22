import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/event.dart';

class EventTablePage extends StatefulWidget {
  final List<Event> userEvents;

  const EventTablePage({required Key key, required this.userEvents}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EventTablePageState createState() => _EventTablePageState();
}

class _EventTablePageState extends State<EventTablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Table'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Tanggal Pendampingan')),
            DataColumn(label: Text('Dampingan')),
            DataColumn(label: Text('Media')),
            DataColumn(label: Text('Status Laporan')),
          ],
          rows: widget.userEvents.map((event) {
            return DataRow(
              cells: [
                DataCell(Text('${event.date.day}/${event.date.month}/${event.date.year}')),
                DataCell(Text(event.initial)),
                DataCell(Text(event.media)),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
