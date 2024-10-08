// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/api/logic/dampingan_logic.dart';
import 'package:ta_peersupervision/api/logic/psusers_logic.dart';
import 'package:ta_peersupervision/api/repository/dampingan_repository.dart';
import 'package:ta_peersupervision/api/repository/psusers_repository.dart';
//import 'package:ta_peersupervision/dummy/usedatanananggota_database.dart';
import 'package:ta_peersupervision/dummy/usedatanggota_database.dart';
import 'package:ta_peersupervision/widgets/bkpopup_editanggota.dart';

class DataTableAnggota extends StatefulWidget {
  final Function(String, String, String, bool, bool) onSubmit;

  const DataTableAnggota({super.key, required this.onSubmit});

  @override
  // ignore: library_private_types_in_public_api
  _DataTableAnggotaState createState() => _DataTableAnggotaState();
}

class _DataTableAnggotaState extends State<DataTableAnggota> {
  String _searchText = '';
  bool _ascending = false; // Initial sorting order
  int _sortColumnIndex = 3; // Initial sort column index

  PSUsersRepository repository = PSUsersRepository();
  late Future<List<FreqPS>> _freqPSFuture;
  late Future<List<FreqDampingan>> _freqDampinganFuture;

  DampinganRepository dampinganList = DampinganRepository();

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
              child: FutureBuilder<List<PSUser>>(
                future: repository.fetchUsers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No active users found');
                  } else {
                    List<PSUser> users = _searchText.isEmpty
                        ? snapshot.data!
                        : snapshot.data!.where((user) {
                            return user.name.toLowerCase().contains(_searchText.toLowerCase()) ||
                                   user.nimAsString.toLowerCase().contains(_searchText.toLowerCase()) ||
                                   user.role.toLowerCase().contains(_searchText.toLowerCase());
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
                        compare = _getFrequency(freqData, a.nim.toString()).compareTo(_getFrequency(freqData, b.nim.toString()));
                      } else {
                        compare = _getDampinganCount(dampinganData, a.nim.toString()).compareTo(_getDampinganCount(dampinganData, b.nim.toString()));
                      }
                      return _ascending ? compare : -compare;
                    });

                    return DataTable(
                      sortColumnIndex: _sortColumnIndex,
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

  List<DataRow> _buildFilteredRows(List<PSUser> users, List<FreqPS> freqData, List<FreqDampingan> dampinganData) {
    return List<DataRow>.generate(
      users.length,
      (index) => DataRow(
        cells: [
          DataCell(SelectableText(users[index].role)),
          DataCell(SelectableText(users[index].name)),
          DataCell(SelectableText(users[index].nimAsString)),
          DataCell(SelectableText(_getFrequency(freqData, users[index].nim.toString()).toString())),
          DataCell(SelectableText(_getDampinganCount(dampinganData, users[index].nim.toString()).toString())),
          DataCell(
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showEditDialog(context, users[index].name, users[index].nimAsString);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue,
                  ),
                  child: const Icon(Icons.edit),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    _showDetailsDialog(context, users[index].name, users[index].nimAsString);
                  },
                  child: const Text('Detail'),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    _showNonActivateDialog(context, users[index].name, users[index].nimAsString);
                  },
                  child: const Text('X', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditDialog(BuildContext context, String name, String nim) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return UpdatePSUserDialog(
          name: name,
          nim: nim,
          onSubmit: (name, nim, password, isAdmin) {
            // Lakukan sesuatu dengan data yang diperbarui
          },
        );
      },
    );
  }

  Future<void> _fetchActiveUsers() async {
    try {
      // Mengambil data anggota aktif dari repository
      List<PSUser> activeUsers = await repository.fetchUsers();
      
      // Update tampilan jika perlu
      setState(() {
        // Mengisi data dari hasil pengambilan data
        dataDatabase = activeUsers.map((user) => {
          'role': user.role,
          'name': user.name,
          'nim': user.nim.toString(),
        }).toList();
      });
    } catch (error) {
      // Penanganan kesalahan jika diperlukan
      print('Error fetching active users: $error');
    }
  }

/*  Future<void> _fetchNActiveUsers() async {
    try {
      // Mengambil data anggota aktif dari repository
      List<NonActiveUser> nactiveUsers = await repository.fetchNAUsers();
      
      // Update tampilan jika perlu
      setState(() {
        // Mengisi data dari hasil pengambilan data
        dataNADatabase = nactiveUsers.map((user) => {
          'role': user.role,
          'name': user.name,
          'nim': user.nanimAsString,
          'tahun': user.yearAsString,
        }).toList();
      });
    } catch (error) {
      // Penanganan kesalahan jika diperlukan
      print('Error fetching Non active users: $error');
    }
  }*/

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

  void _showNonActivateDialog(BuildContext context, String name, String nim) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Status Anggota akan Tidak Aktif'),
          content: Text('Anda akan menon-aktifkan $name'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
              NonActivate nonactivate = NonActivate(psnim: int.tryParse(nim) ?? 0);
              // Implementasi logika menon-aktifkan anggota
              await repository.nonActivate(nonactivate: nonactivate);

              // Setelah proses nonaktif selesai, perbarui daftar anggota aktif
              await _fetchActiveUsers();
              //await _fetchNActiveUsers();

              Navigator.of(context).pop();
              Get.snackbar('Status Anggota Pendamping Sebaya ITB', '$name telah dinon-aktifkan',
                backgroundColor: Colors.green, colorText: Colors.white);
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              child: const Text('Non-Aktifkan'),
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