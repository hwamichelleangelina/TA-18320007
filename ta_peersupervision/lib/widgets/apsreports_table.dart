import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/dummy/usereport_database.dart';
import 'package:ta_peersupervision/pages/report_list_page/apsreport_isi.dart';

class APSReportsTable extends StatefulWidget {
  const APSReportsTable({super.key});

  @override
  State<APSReportsTable> createState() => _APSReportsTableState();
}

class _APSReportsTableState extends State<APSReportsTable> {
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
                    child: const Text('Jadwal Pendampingan',
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
          DataCell(Text(filteredData[index]['date'] ?? '')),
          DataCell(
            Row(
              children: [
                if (filteredData[index]['filled'] == 'Tidak')
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                    context,
                      MaterialPageRoute(builder: (context) =>
                      APSReportForm(repname: filteredData[index]['name']?? '',
                      repps: filteredData[index]['ps']?? '',
                      repdate: filteredData[index]['date']?? '',
                      repkeyword: filteredData[index]['keyword']?? '',),),
                    );
                  },
                  child: const Text('Lengkapi Laporan'),
                ),
                if (filteredData[index]['filled'] == 'Ya')
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 99, 255, 148),
                    foregroundColor: CustomColor.purpleprimary, // Warna teks tombol
                  ),
                  onPressed: () {  }, 
                  child: const Text('Laporan Tersimpan'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
