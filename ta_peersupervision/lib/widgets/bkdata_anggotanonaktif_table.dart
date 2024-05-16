import 'package:flutter/material.dart';
import 'package:ta_peersupervision/api/logic/psusers_logic.dart';
import 'package:ta_peersupervision/api/repository/psusers_repository.dart';
import 'package:ta_peersupervision/dummy/usereport_database.dart';

class DataTableAnggotaNonAktif extends StatefulWidget {
  final Function(String, String, String, bool, bool) onSubmit;

  const DataTableAnggotaNonAktif({super.key, required this.onSubmit});

  @override
  // ignore: library_private_types_in_public_api
  _DataTableAnggotaNonAktifState createState() => _DataTableAnggotaNonAktifState();
}

class _DataTableAnggotaNonAktifState extends State<DataTableAnggotaNonAktif> {
  String _searchText = '';
  bool _ascending = false; // Initial sorting order

  bool psisActive = false;
  bool psisAdmin = false;

  PSUsersRepository repository = PSUsersRepository();

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
              child: FutureBuilder<List<NonActiveUser>>(
                future: repository.fetchNAUsers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No active users found');
                  } else {
                    List<NonActiveUser> users = _searchText.isEmpty
                        ? snapshot.data!
                        : snapshot.data!.where((user) {
                            return user.name.toLowerCase().contains(_searchText.toLowerCase()) ||
                                   user.nanimAsString.toLowerCase().contains(_searchText.toLowerCase()) ||
                                   user.role.toLowerCase().contains(_searchText.toLowerCase()) ||
                                   user.yearAsString.toLowerCase().contains(_searchText.toLowerCase());
                                   
                          }).toList();

                    users.sort((a, b) => _ascending
                        ? _calculateFrequency(a.name).compareTo(_calculateFrequency(b.name))
                        : _calculateFrequency(b.name).compareTo(_calculateFrequency(a.name)));

                    return DataTable(
                      sortColumnIndex: 3, // Index kolom "Frekuensi Pendampingan"
                      sortAscending: _ascending,
                      columns: [
                        DataColumn(
                          label: Container(
                            alignment: Alignment.center,
                            child: const Text('', textAlign: TextAlign.center),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            alignment: Alignment.center,
                            child: const Text('Nama Pendamping Sebaya', textAlign: TextAlign.center),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            alignment: Alignment.center,
                            child: const Text('NIM',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            alignment: Alignment.center,
                            child: const Text('Tahun Mulai Aktif',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            alignment: Alignment.center,
                            child: const Text('Frekuensi Pendampingan',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                      rows: _buildFilteredRows(users),
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

  List<DataRow> _buildFilteredRows(List<NonActiveUser> users) {
    return List<DataRow>.generate(
      users.length,
      (index) => DataRow(
        cells: [
          DataCell(Text(users[index].role)),
          DataCell(Text(users[index].name)),
          DataCell(Text(users[index].nanimAsString)),
          DataCell(Text(users[index].yearAsString)),
          DataCell(
            Text(_calculateFrequency(users[index].name).toString()),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk menghitung frekuensi kemunculan nama dalam dataFromDatabase
  int _calculateFrequency(String name) {
    int frequency = 0;
    for (var data in dataFromDatabase) {
      if (data['ps'] == name) {
        frequency++;
      }
    }
    return frequency;
  }

}