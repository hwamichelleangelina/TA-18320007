// lib/widgets/card_jadwal.dart

import 'package:flutter/material.dart';
import 'package:ta_peersupervision/api/shared_preferences/jadwal_data_manager.dart';

class APSReportTable extends StatelessWidget {
  final JadwalList jadwal;

  const APSReportTable({super.key, required this.jadwal});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(jadwal.initial),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("ID Dampingan: ${jadwal.reqid}", style: const TextStyle(fontWeight: FontWeight.bold),),
            Text("Nomor Jadwal: ${jadwal.jadwalid}"),
            Text("Tanggal Pendampingan: ${jadwal.tanggal}"),
          ],
        ),
      ),
    );
  }
}
