import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get.dart';
import 'package:ta_peersupervision/api/logic/laporan_logic.dart';
import 'package:ta_peersupervision/api/repository/laporan_repository.dart';
//import 'package:ta_peersupervision/constants/colors.dart';

class DataTableWithDownloadButton extends StatefulWidget {
  const DataTableWithDownloadButton({super.key});

  @override
  State<DataTableWithDownloadButton> createState() => _DataTableWithDownloadButtonState();
}

class _DataTableWithDownloadButtonState extends State<DataTableWithDownloadButton> {
  String _searchText = '';
  late Future<List<Laporan>> _futureLaporan;

  LaporanRepository repository = LaporanRepository();

  @override
  void initState() {
    super.initState();
    _futureLaporan = repository.fetchLaporan();
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
            onChanged: (value) {
              setState(() {
                _searchText = value;
              });
            },
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder<List<Laporan>>(
                future: _futureLaporan,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No data found');
                  } else {
                    List<Laporan> laporanList = snapshot.data!;
                    List<Laporan> filteredLaporan = _searchText.isEmpty
                        ? laporanList
                        : laporanList.where((laporan) {
                            return laporan.initial!.toLowerCase().contains(_searchText.toLowerCase()) ||
                                   laporan.psname!.toLowerCase().contains(_searchText.toLowerCase()) ||
                                   laporan.tanggalKonversi.toString().toLowerCase().contains(_searchText.toLowerCase());
                          }).toList();

                    return DataTable(
                      columns: const [
                        DataColumn(label: Text('Inisial Dampingan')),
                        DataColumn(label: Text('Pendamping Sebaya', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Jadwal Pendampingan', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('ID Jadwal', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Rekomendasi Rujukan', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Aksi', style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                      rows: filteredLaporan.map((laporan) {
                        return DataRow(
                          cells: [
                            DataCell(Text(laporan.initial ?? '')),
                            DataCell(Text(laporan.psname ?? '')),
                            DataCell(Text(laporan.tanggalKonversi.toString())),
                            DataCell(Text(laporan.jadwalid.toString())),
                            DataCell(Text(laporan.isRecommended == 1 ? 'Ya' : 'Tidak')),
                            DataCell(
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _showDownloadDialog(context, laporan.initial ?? '');
                                    },
                                    child: const Text('Download'),
                                  ),
                                  const SizedBox(width: 8.0),
                                  ElevatedButton(
                                    onPressed: () {
                                      _showDetail(context, laporan);
                                    },
                                    child: const Text('Lihat Detail'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDetail(BuildContext context, Laporan laporan) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Laporan Proses Pendampingan',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              children: [
                const SizedBox(height: 20),
                ListTile(title: Text('Inisial Dampingan: ${laporan.initial ?? "Unknown"}')),
                ListTile(title: Text('Pendamping Sebaya: ${laporan.psname ?? "Unknown"}')),
                ListTile(title: Text('Tanggal Pendampingan: ${laporan.tanggalKonversi ?? "Unknown"}')),
                ListTile(title: Text('Kata Kunci Masalah Dampingan: ${laporan.katakunci ?? "Unknown"}')),
                const SizedBox(height: 30),
                const Text(
                  "Gambaran Permasalahan Dampingan",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                ListTile(title: Text(laporan.gambaran ?? '')),
                const SizedBox(height: 30),
                const Text(
                  "Proses Pendampingan yang Dilakukan",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                ListTile(title: Text(laporan.proses ?? '')),
                const SizedBox(height: 30),
                const Text(
                  "Hasil Akhir dari Proses Pendampingan",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                ListTile(title: Text(laporan.hasil ?? '')),
                const SizedBox(height: 30),
                const Text(
                  "Kendala Selama Pendampingan",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                ListTile(title: Text(laporan.kendala ?? '')),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tutup'),
            )
          ],
        );
      },
    );
  }

  void _showDownloadDialog(BuildContext context, String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Download File'),
          content: Text('Anda akan mendownload file untuk $name.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Implementasi logika unduhan di sini
                Get.snackbar('title', 'message');
              },
              child: const Text('Download'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 248, 146, 139)),
              ),
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }
}