// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:ta_peersupervision/api/repository/laporan_repository.dart';
import 'package:ta_peersupervision/widgets/bkallreports_table.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  _LaporanPageState createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  List laporanList = [];
  List filteredLaporanList = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchAllLaporan();
  }

  fetchAllLaporan() async {
    try {
      final laporan = await Report.fetchAllLaporan();
      setState(() {
        laporanList = laporan;
        filteredLaporanList = laporan;
      });
    } catch (e) {
      print(e);
    }
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredLaporanList = laporanList.where((laporan) {
        final inisialDampingan = laporan['Inisial Dampingan'].toLowerCase();
        final pendampingSebaya = laporan['Pendamping Sebaya'].toLowerCase();
        final jadwalPendampingan = laporan['Jadwal Pendampingan'].toLowerCase();
        final searchLower = query.toLowerCase();

        return inisialDampingan.contains(searchLower) ||
               pendampingSebaya.contains(searchLower) ||
               jadwalPendampingan.contains(searchLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: updateSearchQuery,
            ),
          ),
          Expanded(
            child: LaporanTable(laporanList: filteredLaporanList),
          ),
        ],
      ),
    );
  }
}