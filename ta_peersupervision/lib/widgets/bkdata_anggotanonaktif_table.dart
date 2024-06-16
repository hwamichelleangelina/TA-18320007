import 'package:flutter/material.dart';
import 'package:ta_peersupervision/api/logic/dampingan_logic.dart';
import 'package:ta_peersupervision/api/logic/psusers_logic.dart';
import 'package:ta_peersupervision/api/repository/dampingan_repository.dart';
import 'package:ta_peersupervision/api/repository/psusers_repository.dart';

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
  int _sortColumnIndex = 3; // Initial sort column index

  PSUsersRepository repository = PSUsersRepository();
  late Future<List<FreqPS>> _freqPSFuture;
  late Future<List<FreqDampingan>> _freqDampinganFuture;

  @override
  void initState() {
    super.initState();
    _freqPSFuture = repository.fetchFreqPS();
    _freqDampinganFuture = repository.fetchCountDampingan();
  }

  bool psisActive = false;
  bool psisAdmin = false;

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

        return FutureBuilder<List<FreqPS>>(
          future: _freqPSFuture,
          builder: (context, freqSnapshot) {
            if (freqSnapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (freqSnapshot.hasError) {
              return Text('Error: ${freqSnapshot.error}');
            } else if (!freqSnapshot.hasData || freqSnapshot.data!.isEmpty) {
              return const Text('No frequency data found');
            } else {
              List<FreqPS> freqData = freqSnapshot.data!;
              return FutureBuilder<List<FreqDampingan>>(
                future: _freqDampinganFuture,
                builder: (context, dampinganSnapshot) {
                  if (dampinganSnapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (dampinganSnapshot.hasError) {
                    return Text('Error: ${dampinganSnapshot.error}');
                  } else if (!dampinganSnapshot.hasData || dampinganSnapshot.data!.isEmpty) {
                    return const Text('No dampingan data found');
                  } else {
                    List<FreqDampingan> dampinganData = dampinganSnapshot.data!;
                    users.sort((a, b) {
                      int compare;
                      if (_sortColumnIndex == 3) {
                        compare = _getFrequency(freqData, a.nanim.toString()).compareTo(_getFrequency(freqData, b.nanim.toString()));
                      } else {
                        compare = _getDampinganCount(dampinganData, a.nanim.toString()).compareTo(_getDampinganCount(dampinganData, b.nanim.toString()));
                      }
                      return _ascending ? compare : -compare;
                    });

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
                            child: const Text('Pendampingan',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          onSort: (columnIndex, ascending) {
                            setState(() {
                              _sortColumnIndex = columnIndex;
                              _ascending = ascending;
                            });
                          },
                        ),
                        DataColumn(
                          label: Container(
                            alignment: Alignment.center,
                            child: const Text('Dampingan',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          onSort: (columnIndex, ascending) {
                            setState(() {
                              _sortColumnIndex = columnIndex;
                              _ascending = ascending;
                            });
                          },
                        ),
                        DataColumn(
                          label: Container(
                            alignment: Alignment.center,
                            child: const Text('Keterangan',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                      rows: _buildFilteredRows(users, freqData, dampinganData),
                      );
                      }
                    },
                    );
                    }
                    },
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

  List<DataRow> _buildFilteredRows(List<NonActiveUser> users, List<FreqPS> freqData, List<FreqDampingan> dampinganData) {
    return List<DataRow>.generate(
      users.length,
      (index) => DataRow(
        cells: [
          DataCell(Text(users[index].role)),
          DataCell(Text(users[index].name)),
          DataCell(Text(users[index].nanimAsString)),
          DataCell(Text(users[index].yearAsString)),
          DataCell(Text(_getFrequency(freqData, users[index].nanim.toString()).toString())),
          DataCell(Text(_getDampinganCount(dampinganData, users[index].nanim.toString()).toString())),
          DataCell(
            ElevatedButton(
              onPressed: () {
                _showDetailsDialog(context, users[index].name, users[index].nanimAsString);
              },
              child: const Text('Detail'),
            ),
          ),
        ],
      ),
    );
  }

  void _showDetailsDialog(BuildContext context, String name, String nim) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dampingan Ditangani oleh $name'),
          content: SizedBox(
          width: double.maxFinite, // Atur lebar dialog menjadi maksimum
          height: double.maxFinite,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: 
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FutureBuilder<List<Dampingan>>(
                    future: fetchDampingan(int.parse(nim)),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No data available');
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final item = snapshot.data![index];
                            return ListTile(
                              title: Text('ID Dampingan: ${item.reqid}'),
                              subtitle: Text('Inisial Dampingan: ${item.initial}'),
                              onTap: () {
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),),
             actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Tutup'),
              ),
            ],         
          );
        },
      );
    }

  // Fungsi untuk menghitung frekuensi kemunculan nama dalam dataFromDatabase
  int _getFrequency(List<FreqPS> freqData, String nim) {
    final freq = freqData.firstWhere(
      (f) => f.psnim.toString() == nim,
      orElse: () => FreqPS(psnim: int.parse(nim), count: 0),
    );
    return freq.count!;
  }

  int _getDampinganCount(List<FreqDampingan> dampinganData, String nim) {
    final count = dampinganData.firstWhere(
      (f) => f.psnim.toString() == nim,
      orElse: () => FreqDampingan(psnim: int.parse(nim), count: 0),
    );
    return count.count!;
  }

}