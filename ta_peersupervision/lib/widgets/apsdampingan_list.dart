// dampingan_list.dart
// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ta_peersupervision/api/logic/dampingan_logic.dart';
import 'package:ta_peersupervision/api/repository/dampingan_repository.dart';
import 'package:ta_peersupervision/api/shared_preferences/jadwal_data_manager.dart';
import 'package:ta_peersupervision/constants/colors.dart';

class DampinganList extends StatefulWidget {
  final int psnim;

  const DampinganList({super.key, required this.psnim});

  @override
  _DampinganListState createState() => _DampinganListState();
}

class _DampinganListState extends State<DampinganList> {
  late Future<List<Dampingan>> futureDampingan;
  DateTime? selectedDate;
  int psnim = 0;

  DampinganRepository repository = DampinganRepository();

  // Konversi DateTime ke String
  String formatDate(DateTime? date) {
    if (date == null) {
      return 'N/A';
    }
    final DateFormat formatter = DateFormat('d MMMM y');
    return formatter.format(date);
  }

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
//                const Text('Tanggal Pertemuan:'),
//                const SizedBox(height: 8.0),
//                OutlinedButton(
/*                  onPressed: () async {
                    var pickedDate = await showDatePicker(
                      context: context,
                      initialDate: 
                        item.tanggal ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );

                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                        pickedDate = null;
                      });
                    }
                  },
                  child: Text(
                    item.tanggal == null
                        ? 'Pilih Tanggal'
                        : formatDate(item.tanggal),
                  ),
                ),*/
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 248, 146, 139)),
              ),
              child: const Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Jadwalkan Pendampingan'),
              onPressed: () async {
//                print(item.reqid);
                // Menyimpan nilai di ReqidStorage
                ReqidStorage.setReqid(item.reqid!);
//                print(ReqidStorage.getReqid().toString());
                Get.toNamed('/aps-jadwal');
                // Penyimpanan tanggal pendampingan
/*                if (selectedDate == null) {
                  Get.snackbar('Rencanakan jadwal Pendampingan', 'Tanggal harus terisi!',
                    backgroundColor: Colors.red,
                    colorText: Colors.white);
                }
                else {
//                  JadwalPendampingan jadwal = JadwalPendampingan(
//                    reqid: item.reqid,
//                    tanggal: formatDateSQL(selectedDate),
//                  );

//                  print('SelectedDate: $selectedDate');
//                  print('reqID: ${item.reqid}');
//                  repository.updateDampinganTanggal(jadwalPendampingan: jadwal).then((value) {
//                    Navigator.of(context).pop();
//                  });
//                    Get.snackbar('Rencanakan jadwal Pendampingan', 'Pendampingan berhasil dijadwalkan',
//                      backgroundColor: Colors.green, colorText: Colors.white); 
//                  selectedDate = null;
//                  print('SelectedDate erase: $selectedDate');
                  }*/
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
                        color:  CustomColor.purpleBg2,
                      ),
                      child: 
                        ListTile(
                          title: Text('ID Dampingan: ${item.reqid.toString()} - ${item.initial}'),
                          subtitle: /*const Text(''),*/ Text('Kontak Dampingan: ${item.kontak}\nKata Kunci Masalah: ${item.katakunci}'),
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