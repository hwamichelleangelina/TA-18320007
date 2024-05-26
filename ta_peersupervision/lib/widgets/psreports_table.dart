// lib/widgets/card_jadwal.dart

import 'package:flutter/material.dart';
import 'package:ta_peersupervision/api/shared_preferences/jadwal_data_manager.dart';


class PSReportsTable extends StatelessWidget {
  final JadwalList jadwal;
  final VoidCallback onTap;

  const PSReportsTable({
    super.key,
    required this.jadwal,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add padding
      child: Card(
        child: ListTile(
          title: Text('Jadwal ID: ${jadwal.jadwalid}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Text("ID Dampingan: ${jadwal.reqid}", style: const TextStyle(fontWeight: FontWeight.bold),),
                Text("Nomor Jadwal: ${jadwal.jadwalid}"),
                Text("Tanggal Pendampingan: ${jadwal.formattedTanggal}"),
              ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: onTap,
          ),
        ),
      ),
    );
  }
}