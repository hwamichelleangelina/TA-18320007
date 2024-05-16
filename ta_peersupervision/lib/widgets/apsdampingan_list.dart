// dampingan_list.dart
// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/api/logic/dampingan_logic.dart';
import 'package:ta_peersupervision/api/repository/dampingan_repository.dart';

class DampinganList extends StatefulWidget {
  final int psnim;

  const DampinganList({super.key, required this.psnim});

  @override
  _DampinganListState createState() => _DampinganListState();
}

class _DampinganListState extends State<DampinganList> {
  late Future<List<Dampingan>> futureDampingan;
  DateTime? selectedDate;

  DampinganRepository repository = DampinganRepository();

  @override
  
  void initState() {
    super.initState();
    // print('widget: ${widget.psnim}');
    futureDampingan = fetchDampingan(widget.psnim);
  }

  void _showDetailsDialog(Dampingan item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dampingan: ${item.initial}'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Request ID: ${item.reqid}'),
                Text('Inisial Dampingan: ${item.initial}'),
                Text('Gender: ${item.gender ?? 'N/A'}'),
                Text('Fakultas: ${item.fakultas ?? 'N/A'}'),
                Text('Angkatan: ${item.angkatan ?? 'N/A'}'),
                Text('Kampus: ${item.kampus ?? 'N/A'}'),
                Text('Media Kontak: ${item.mediakontak}'),
                Text('Kontak: ${item.kontak}'),
                Text('Kata Kunci Masalah: ${item.katakunci}'),
                Text('Sesi Pendampingan: ${item.sesi}'),
                const SizedBox(height: 16.0),
                Text('Nama Pendamping Sebaya: ${item.psname}'),
                Text('NIM Pendamping Sebaya: ${item.psnim}'),

                const SizedBox(height: 16),
                const Text('Tanggal Pertemuan:'),
                const SizedBox(height: 8.0),
                OutlinedButton(
                  onPressed: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Text(
                    selectedDate == null
                        ? 'Pilih Tanggal'
                        : '${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 248, 146, 139)),
              ),
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Simpan'),
              onPressed: () async {
                // Penyimpanan tanggal pendampingan
                if (selectedDate == null) {
                  Get.snackbar('Rencanakan jadwal Pendampingan', 'Tanggal harus terisi!',
                    backgroundColor: Colors.red,
                    colorText: Colors.white);
                }
                else {
                  DateTime fixedDate = DateTime.now();
                  fixedDate = selectedDate!;
                  
                  JadwalPendampingan jadwal = JadwalPendampingan(
                    reqid: item.reqid,
                    tanggal: fixedDate,
                  );

                  repository.updateDampinganTanggal(dampingan: jadwal).then((value) {
                    Navigator.of(context).pop();
                  });
                    Get.snackbar('Rencanakan jadwal Pendampingan', 'Pendampingan berhasil dijadwalkan',
                      backgroundColor: Colors.green, colorText: Colors.white); 
                  }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Dampingan>>(
      future: futureDampingan,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No Data Available'));
        } else {
          return ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var item = snapshot.data![index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8), // Spasi kanan-kiri dan antar tile
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), // Edge curve
                        color: const Color.fromARGB(255, 115, 89, 147), // Ganti warna sesuai kebutuhan
                      ),
                      child: 
                        ListTile(
                          title: Text(item.initial),
                          subtitle: /*const Text(''),*/ Text('Tanggal Pendampingan: ${item.tanggal ?? 'N/A'}'),
                          onTap: () {
                            _showDetailsDialog(item);
                          },
                        ),
                    );
                  },
                );
        }
      },
    );
  }
}