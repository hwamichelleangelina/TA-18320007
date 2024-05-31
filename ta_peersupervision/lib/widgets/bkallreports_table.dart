// lib/laporan_table.dart
import 'package:flutter/material.dart';

class LaporanTable extends StatelessWidget {
  final List laporanList;

  const LaporanTable({super.key, required this.laporanList});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Inisial Dampingan')),
        DataColumn(label: Text('Pendamping Sebaya')),
        DataColumn(label: Text('Jadwal Pendampingan')),
        DataColumn(label: Text('ID Jadwal')),
        DataColumn(label: Text('Rekomendasi Rujukan')),
        DataColumn(label: Text('Aksi')),
      ],
      rows: laporanList.map((laporan) {
        return DataRow(cells: [
          DataCell(Text(laporan['Inisial Dampingan'])),
          DataCell(Text(laporan['Pendamping Sebaya'])),
          DataCell(Text(laporan['Jadwal Pendampingan'])),
          DataCell(Text(laporan['ID Jadwal'].toString())),
          DataCell(Text(laporan['Rekomendasi Rujukan'])),
          DataCell(
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implementasi Download
                  },
                  child: const Text('Download'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Implementasi Lihat Detail
                  },
                  child: const Text('Lihat Detail'),
                ),
              ],
            ),
          ),
        ]);
      }).toList(),
    );
  }
}
