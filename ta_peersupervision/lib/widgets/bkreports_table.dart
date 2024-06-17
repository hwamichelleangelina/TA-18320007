import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore_for_file: avoid_print, library_private_types_in_public_api, use_build_context_synchronously
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:ta_peersupervision/constants/colors.dart';
// Import universal_html untuk penggunaan elemen HTML di web
import 'package:universal_html/html.dart' as html;

class DataTableWithDownloadButton extends StatefulWidget {
  const DataTableWithDownloadButton({super.key});

  @override
  State<DataTableWithDownloadButton> createState() => _DataTableWithDownloadButtonState();
}

class _DataTableWithDownloadButtonState extends State<DataTableWithDownloadButton> {
  List<dynamic> _data = [];
  List<dynamic> _filteredData = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  String formattedTanggal(String tanggalString) {
    final DateTime dateTime = DateTime.parse(tanggalString);
    return DateFormat('d MMMM y').format(dateTime);
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
                title: const Text('Laporan Proses Pendampingan', textAlign: TextAlign.center,),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Inisial Dampingan: ${report['initial'] ?? 'N/A'}'),
                      const SizedBox(height: 5),
                      Text('ID Dampingan: ${report['reqid'] ?? 'N/A'}'),
                      const SizedBox(height: 10),
                      const SizedBox(height: 5),
                      Text('Pendamping Sebaya: ${report['psname'] ?? 'N/A'}'),
                      const SizedBox(height: 5),
                      Text('NIM Pendamping Sebaya: ${report['psnim'] ?? 'N/A'}'),
                      const SizedBox(height: 5),
                      const SizedBox(height: 10),
                      Text('Jadwal ID: ${report['jadwalid'] ?? 'N/A'}'),
                      const SizedBox(height: 5),
                      Text('Tanggal Pendampingan: ${formattedTanggal(report['tanggalKonversi'])}'),
                      const SizedBox(height: 5),
                      const SizedBox(height: 10),
                      Text('Direkomendasikan untuk Rujuk ke Psikolog: ${report['isRecommended'] == 1 ? 'PERLU SEGERA' : 'Tidak Perlu'}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                      const SizedBox(height: 5),
                      Text('Kata Kunci Permasalahan: ${report['katakunci'] ?? 'N/A'}'),
                      const SizedBox(height: 5),
                      const SizedBox(height: 35),
                      const Center(
                        child: Text(
                          'Gambaran Permasalahan Dampingan',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('${report['gambaran'] ?? 'N/A'}'),
                      const SizedBox(height: 35),
                      const Center(
                        child: Text(
                          'Proses Pendampingan yang Dilakukan',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('${report['proses'] ?? 'N/A'}'),
                      const SizedBox(height: 35),
                      const Center(
                        child: Text(
                          'Hasil Akhir dari Proses Pendampingan',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('${report['hasil'] ?? 'N/A'}'),
                      const SizedBox(height: 35),
                      const Center(
                        child: Text(
                          'Kendala selama Proses Pendampingan',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('${report['kendala'] ?? 'N/A'}'),
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
        final isRecLower = (item['isRecommended'] == 1 ? 'Perlu Segera' : 'Tidak Perlu').toLowerCase();
        final tanggalLower = formattedTanggal(item['tanggalKonversi']).toLowerCase();
        final searchLower = query.toLowerCase();
        return initialLower.contains(searchLower) ||
               psnameLower.contains(searchLower) ||
               isRecLower.contains(searchLower) ||
               tanggalLower.contains(searchLower);
      }).toList();
    });
  }

  Future<void> _downloadFile(int jadwalid) async {
    final url = 'http://localhost:3000/report/download/$jadwalid';

    if (kIsWeb) {
      // Logika unduhan untuk web
      // ignore: unused_local_variable
      final html.AnchorElement anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "Laporan_$jadwalid.pdf")
        ..click();
    } else {
      // Logika unduhan untuk Android/iOS
      if (await Permission.storage.request().isGranted) {
        Directory? directory = await getExternalStorageDirectory();
        String newPath = "";
        List<String> paths = directory!.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/$folder";
          } else {
            break;
          }
        }
        newPath = "$newPath/Download";
        directory = Directory(newPath);

        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }

        String filePath = '${directory.path}/Laporan_$jadwalid.pdf';
        try {
          await Dio().download(
            url,
            filePath,
            onReceiveProgress: (received, total) {
              if (total != -1) {
                print("${(received / total * 100).toStringAsFixed(0)}%");
              }
            },
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Laporan berhasil diunduh: $filePath')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal mengunduh laporan: $e')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Izin penyimpanan tidak diberikan')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: TextField(
            decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            labelText: 'Pencarian',
            prefixIcon: Icon(Icons.search),
            ),
            onChanged: _searchData,
          ),
        ),
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Dampingan')),
                  DataColumn(label: Text('Pendamping Sebaya')),
                  DataColumn(label: Text('Jadwal ID')),
                  DataColumn(label: Text('Tanggal')),
                  DataColumn(label: Text('Rekomendasi Rujukan')),
                  DataColumn(label: Text('Aksi')),
                ],
                rows: _filteredData.map((item) {
                  return DataRow(cells: [
                    DataCell(Text(item['initial'] ?? 'N/A')),
                    DataCell(Text(item['psname'] ?? 'N/A')),
                    DataCell(Text(item['jadwalid'].toString())),
                    DataCell(Text(formattedTanggal(item['tanggalKonversi']))),
                    DataCell(Text(item['isRecommended'] == 1
                      ? 'PERLU SEGERA'
                      : 'Tidak Perlu')),
                    DataCell(
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _showDownloadDialog(context, item['initial'], item['jadwalid']);
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
    );
  }

  void _showDownloadDialog(BuildContext context, String name, int jadwalid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Download File'),
          content: Text('Anda akan mendownload file untuk $name - ID Jadwal: $jadwalid.'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await _downloadFile(jadwalid);
                Navigator.of(context).pop();
                Get.snackbar('Pengunduhan Dokumen Laporan Proses Pendampingan', 'Laporan Proses Pendampingan dengan ID Jadwal: $jadwalid berhasil diunduh',
                  backgroundColor: Colors.green, colorText: Colors.white);
              },
              child: const Text('Download'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }
}