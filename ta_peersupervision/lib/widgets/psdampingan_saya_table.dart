/*import 'package:flutter/material.dart';
import 'package:ta_peersupervision/dummy/dampingan_saya_database.dart';
import 'package:ta_peersupervision/pages/jadwal_page/psjadwal_page.dart';

class PSDampinganList extends StatefulWidget {
  const PSDampinganList({super.key});

  @override
  State<PSDampinganList> createState() => _PSDampinganListState();
}

class _PSDampinganListState extends State<PSDampinganList> {
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child:
        TextField(
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
            child: DataTable(
              columns: [
                DataColumn(
                  label: Container(
                    alignment: Alignment.center,
                    child: const Text('', textAlign: TextAlign.center,),
                  ),
                ),
                DataColumn(
                  label: Container(
                    alignment: Alignment.center,
                    child: const Text('Kontak',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    alignment: Alignment.center,
                    child: const Text('',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
              rows: _buildFilteredRows(),
            ),
          ),
        ),
    ),
    ],
    );
  }

  List<DataRow> _buildFilteredRows() {
    List<Map<String, String>> filteredData = _searchText.isEmpty
        ? requests
        : requests.where((data) {
          return data.values.any((value) =>
              value.toLowerCase().contains(_searchText.toLowerCase()));
        }).toList();

    return List<DataRow>.generate(
      filteredData.length,
      (index) => DataRow(
        cells: [
          DataCell(Text(filteredData[index]['name'] ?? '')),
          DataCell(Text(filteredData[index]['kontak'] ?? '')),
          DataCell(
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    _showDetail(context, filteredData[index]);
                  },
                  icon: const Icon(Icons.view_headline_rounded),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDetail(BuildContext context, Map<String, String> data) {
    // Implementasi logika untuk menampilkan detail
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detail Dampingan ${data['name']}',
              style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold)
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              children: [
                const SizedBox(height: 20,),
                ListTile(
                  title: Text('Inisial Dampingan: ${data['name']}'),
                ),
                ListTile(
                  title: Text('Kontak: ${data['kontak']}'),
                ),
                ListTile(
                  title: Text('Gender: ${data['gender']}'),
                ),
                ListTile(
                  title: Text('Fakultas: ${data['fakultas']}'),
                ),
                ListTile(
                  title: Text('Angkatan: ${data['angkatan']}'),
                ),
                ListTile(
                  title: Text('Kampus: ${data['kampus']}'),
                ),
                ListTile(
                  title: Text('Kata Kunci Permasalahan: ${data['keyword']}'),
                ),
                ListTile(
                  title: Text('Sesi Pendampingan: ${data['sesi']}'),
                ),
                ListTile(
                  title: Text('Rencana Tanggal Pendampingan: ${data['tanggal']}'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Tutup'),
                ),

                const SizedBox(width: 8,),

                if (data['tanggal'] == null || data['tanggal'] == '')
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PSJadwalPage()),
                      );
                    },
                    child: const Text('Buat Jadwal Pendampingan'),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}*/