// dampingan_list.dart
// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ta_peersupervision/api/logic/dampingan_logic.dart';
import 'package:ta_peersupervision/api/repository/dampingan_repository.dart';
import 'package:ta_peersupervision/api/shared_preferences/jadwal_data_manager.dart';
import 'package:ta_peersupervision/constants/colors.dart';

class PSDampinganList extends StatefulWidget {
  final int psnim;

  const PSDampinganList({super.key, required this.psnim});

  @override
  _PSDampinganListState createState() => _PSDampinganListState();
}

class _PSDampinganListState extends State<PSDampinganList> {
  late Future<List<Dampingan>> futureDampingan;
  DateTime? selectedDate;
  int psnim = 0;

  DampinganRepository repository = DampinganRepository();

  // Konversi DateTime ke String
  String formatDate(DateTime? date) {
    if (date == null) {
      return 'N/A';
    }
    final DateFormat formatter = DateFormat('d MMMM y', 'id');
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
          title: SelectableText('Dampingan: ${item.initial}'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SelectableText('Request ID: ${item.reqid}'),
                SelectableText('Inisial Dampingan: ${item.initial}'),
                SelectableText('Gender: ${item.gender ?? 'N/A'}'),
                SelectableText('Fakultas: ${item.fakultas ?? 'N/A'}'),
                SelectableText('Angkatan: ${item.angkatan ?? 'N/A'}'),
                SelectableText('Tingkat: ${item.tingkat ?? 'N/A'}'),
                SelectableText('Kampus: ${item.kampus ?? 'N/A'}'),
                SelectableText('Media Kontak: ${item.mediakontak}'),
                SelectableText('Kontak: ${item.kontak}'),

                item.katakunci2 == null
                ? SelectableText('Kata Kunci Masalah: ${item.katakunci}')
                : SelectableText('Kata Kunci Masalah: ${item.katakunci}, ${item.katakunci2}'),

                SelectableText('Sesi Pendampingan: ${item.sesi}'),
                const SizedBox(height: 16.0),
                SelectableText('Nama Pendamping Sebaya: ${item.psname}'),
                SelectableText('NIM Pendamping Sebaya: ${item.psnim}'),

                const SizedBox(height: 16),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Jadwalkan Pendampingan'),
              onPressed: () async {
                ReqidStorage.setReqid(item.reqid!);
                Get.toNamed('/ps-jadwal');
              },
            ),
            TextButton(
              child: const Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
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
                    title: SelectableText('ID Dampingan: ${item.reqid.toString()} - ${item.initial}'),
                    subtitle: /*const SelectableText(''),*/ SelectableText('Kontak Dampingan: ${item.kontak}'),
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