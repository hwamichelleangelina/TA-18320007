// ignore_for_file: avoid_print, library_private_types_in_public_api, use_build_context_synchronously
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class LaporanTable extends StatefulWidget {
  const LaporanTable({super.key});

  @override
  _LaporanTableState createState() => _LaporanTableState();
}

class _LaporanTableState extends State<LaporanTable> {
  List<dynamic> _data = [];
  List<dynamic> _filteredData = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/laporan/getLaporan'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['reportlist'] is List) {
          setState(() {
            _data = data['reportlist'];
            _filteredData = _data;
          });
        } else {
          print('Unexpected response format: ${data['reportlist']}');
        }
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void _showDetails(int jadwalid) async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/laporan/getLaporan/$jadwalid'));
      if (response.statusCode == 200) {
        final detail = json.decode(response.body);
        if (detail['report'] is List && detail['report'].isNotEmpty) {
          final report = detail['report'][0];
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Detail Laporan'),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SelectableText('Initial: ${report['initial'] ?? 'N/A'}'),
                      SelectableText('PS Name: ${report['psname'] ?? 'N/A'}'),
                      SelectableText('Jadwal ID: ${report['jadwalid'] ?? 'N/A'}'),
                      SelectableText('Tanggal: ${report['tanggal'] ?? 'N/A'}'),
                      SelectableText('Is Recommended: ${report['isRecommended'] == 1 ? 'Yes' : 'No'}'),
                      SelectableText('Katakunci: ${report['katakunci'] ?? 'N/A'}'),
                      SelectableText('Gambaran: ${report['gambaran'] ?? 'N/A'}'),
                      SelectableText('Proses: ${report['proses'] ?? 'N/A'}'),
                      SelectableText('Hasil: ${report['hasil'] ?? 'N/A'}'),
                      SelectableText('Kendala: ${report['kendala'] ?? 'N/A'}'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Tutup'),
                  ),
                ],
              );
            },
          );
        } else {
          print('Unexpected detail format: ${detail['report']}');
        }
      } else {
        print('Failed to load details');
      }
    } catch (e) {
      print('Error fetching details: $e');
    }
  }

  void _searchData(String query) {
    setState(() {
      _filteredData = _data.where((item) {
        final initialLower = item['initial']?.toLowerCase() ?? '';
        final psnameLower = item['psname']?.toLowerCase() ?? '';
        final tanggalLower = item['tanggal']?.toLowerCase() ?? '';
        final searchLower = query.toLowerCase();
        return initialLower.contains(searchLower) ||
               psnameLower.contains(searchLower) ||
               tanggalLower.contains(searchLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Table'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              labelText: 'Pencarian',
              prefixIcon: Icon(Icons.search),
              ),
              onChanged: _searchData,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Initial')),
                    DataColumn(label: Text('PS Name')),
                    DataColumn(label: Text('Jadwal ID')),
                    DataColumn(label: Text('Tanggal')),
                    DataColumn(label: Text('Is Recommended')),
                    DataColumn(label: Text('Aksi')),
                  ],
                  rows: _filteredData.map((item) {
                    return DataRow(cells: [
                      DataCell(SelectableText(item['initial'] ?? 'N/A')),
                      DataCell(SelectableText(item['psname'] ?? 'N/A')),
                      DataCell(SelectableText(item['jadwalid'].toString())),
                      DataCell(SelectableText(item['tanggal'] ?? 'N/A')),
                      DataCell(SelectableText(item['isRecommended'] == 1 ? 'Yes' : 'No')),
                      DataCell(
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Logic to download the report
                              },
                              child: const Text('Download'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () => _showDetails(item['jadwalid']),
                              child: const Text('Lihat detail'),
                            ),
                          ],
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
