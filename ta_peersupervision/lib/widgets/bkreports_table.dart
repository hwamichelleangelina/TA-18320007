import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/dummy/usereport_database.dart';

class DataTableWithDownloadButton extends StatefulWidget {
  const DataTableWithDownloadButton({super.key});

  @override
  State<DataTableWithDownloadButton> createState() => _DataTableWithDownloadButtonState();
}

class _DataTableWithDownloadButtonState extends State<DataTableWithDownloadButton> {
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
                    child: const Text('Inisial Dampingan', textAlign: TextAlign.center,),
                  ),
                ),
                DataColumn(
                  label: Container(
                    alignment: Alignment.center,
                    child: const Text('Pendamping Sebaya',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    alignment: Alignment.center,
                    child: const Text('Jadwal Pendampingan',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    alignment: Alignment.center,
                    child: const Text('Rekomendasi Rujukan',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    alignment: Alignment.center,
                    child: const Text('Aksi',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
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
        ? dataFromDatabase
        : dataFromDatabase.where((data) {
          return data.values.any((value) =>
              value.toLowerCase().contains(_searchText.toLowerCase()));
        }).toList();

    return List<DataRow>.generate(
      filteredData.length,
      (index) => DataRow(
        cells: [
          DataCell(Text(filteredData[index]['name'] ?? '')),
          DataCell(Text(filteredData[index]['ps'] ?? '')),
          DataCell(Text(filteredData[index]['date'] ?? '')),
          DataCell(Text(filteredData[index]['rujukan'] ?? '')),
          DataCell(
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showDownloadDialog(context, filteredData[index]['name'] ?? '');
                  },
                  child: const Text('Download'),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    _showDetail(context, filteredData[index]);
                  },
                  child: const Text('Lihat Detail'),
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
          title: const Text('Laporan Proses Pendampingan',
              style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)
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
                  title: Text('Pendamping Sebaya: ${data['ps']}'),
                ),
                ListTile(
                  title: Text('Tanggal Pendampingan: ${data['date']}'),
                ),
                ListTile(
                  title: Text('Kata Kunci Masalah Dampingan: ${data['keyword']}'),
                ),

                const SizedBox(height: 30,),
                const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Gambaran Permasalahan Dampingan",
                        style: TextStyle(
                          fontSize: 22,
                          color: CustomColor.whitePrimary,
                        ),
                      ),
                    ]
                ),

                ListTile(
                  title: Text(
                    '${data['laporan1']}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: CustomColor.whitePrimary,
                    ),
                  ),
                ),

                const SizedBox(height: 30,),
                const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Proses Pendampingan yang Dilakukan",
                        style: TextStyle(
                          fontSize: 22,
                          color: CustomColor.whitePrimary,
                        ),
                      ),
                    ]
                ),

                ListTile(
                  title: Text(
                    '${data['laporan1']}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: CustomColor.whitePrimary,
                    ),
                  ),
                ),

                const SizedBox(height: 30,),
                const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Hasil Akhir dari Proses Pendampingan",
                        style: TextStyle(
                          fontSize: 22,
                          color: CustomColor.whitePrimary,
                        ),
                      ),
                    ]
                ),

                ListTile(
                  title: Text(
                    '${data['laporan1']}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: CustomColor.whitePrimary,
                    ),
                  ),
                ),

                const SizedBox(height: 30,),
                const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Kendala Selama Pendampingan",
                        style: TextStyle(
                          fontSize: 22,
                          color: CustomColor.whitePrimary,
                        ),
                      ),
                    ]
                ),

                ListTile(
                  title: Text(
                    '${data['laporan1']}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: CustomColor.whitePrimary,
                    ),
                  ),
                ),

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
                Navigator.of(context).pop();
                _showSnackbar(context, 'Laporan berhasil diunduh');
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

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: const Color.fromARGB(255, 123, 217, 126), // Mengatur warna hijau
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
