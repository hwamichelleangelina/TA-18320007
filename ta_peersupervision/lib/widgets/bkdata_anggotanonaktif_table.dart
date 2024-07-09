// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/api/logic/dampingan_logic.dart';
import 'package:ta_peersupervision/api/logic/psusers_logic.dart';
import 'package:ta_peersupervision/api/repository/dampingan_repository.dart';
import 'package:ta_peersupervision/api/repository/psusers_repository.dart';
import 'package:ta_peersupervision/dummy/usedatanananggota_database.dart';

class DataTableAnggotaNonAktif extends StatefulWidget {
  final Function(String, String, String, bool, bool) onSubmit;

  const DataTableAnggotaNonAktif({super.key, required this.onSubmit});

  @override
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
                            child: const Text('Tahun Aktif',
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
                            child: const Text('Aksi',
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
          DataCell(SelectableText(users[index].role)),
          DataCell(SelectableText(users[index].name)),
          DataCell(SelectableText(users[index].nanimAsString)),
          DataCell(SelectableText(users[index].yearAsString)),
          DataCell(SelectableText(_getFrequency(freqData, users[index].nanim.toString()).toString())),
          DataCell(SelectableText(_getDampinganCount(dampinganData, users[index].nanim.toString()).toString())),
          DataCell(
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showDeleteDialog(context, users[index].name, users[index].nanim);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  child: const Icon(Icons.delete),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    _showDetailsDialog(context, users[index].name, users[index].nanimAsString);
                  },
                  child: const Text('Detail'),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    _showActivateDialog(context, users[index].name, users[index].nanimAsString);
                  },
                  child: const Text('O', style: TextStyle(color: Colors.green)),
                ),
              ],
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
                        return const Text('Belum ada dampingan ditangani');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No data available');
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final item = snapshot.data![index];
                            return ListTile(
                              title: SelectableText('ID Dampingan: ${item.reqid}'),
                              subtitle: SelectableText('Inisial Dampingan: ${item.initial}'),
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

  Future<void> _fetchNAUsers() async {
    try {
      // Mengambil data anggota aktif dari repository
      List<NonActiveUser> activeUsers = await repository.fetchNAUsers();
      
      // Update tampilan jika perlu
      setState(() {
        dataNADatabase = activeUsers.map((user) => {
          'role': user.role,
          'name': user.name,
          'nim': user.nanim.toString(),
        }).toList();
      });
    } catch (error) {
      print('Error fetching non active users: $error');
    }
  }

  void _showActivateDialog(BuildContext context, String name, String nim) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Status Anggota akan Diaktifkan Kembali'),
          content: Text('Anda akan mengaktifkan $name kembali'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
              Activate activate = Activate(psnim: int.tryParse(nim) ?? 0);
              await repository.activate(activate: activate);
              await _fetchNAUsers();
              Navigator.of(context).pop();
              Get.snackbar('Status Anggota Pendamping Sebaya ITB', '$name telah diaktifkan kembali',
                backgroundColor: Colors.green, colorText: Colors.white);
              },
              child: const Text('Aktifkan'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, String name, int nim) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Anggota'),
          content: Text('Anda yakin ingin menghapus $name?'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await _deletePSUser(nim);
                await _fetchNAUsers();
                Navigator.of(context).pop();
                Get.snackbar('Status Anggota Pendamping Sebaya ITB', '$name telah dihapus',
                  backgroundColor: Colors.green, colorText: Colors.white);
              },
              child: const Text('Hapus', style: TextStyle(color: Colors.red),),
            ),
            const SizedBox(width: 10,),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deletePSUser(int nim) async {
    try {
      await repository.deletePSUser(psnim: nim);
    } catch (error) {
      print('Error deleting user: $error');
    }
  }

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