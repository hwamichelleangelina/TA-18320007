import 'package:flutter/material.dart';
import 'package:ta_peersupervision/api/shared_preferences/jadwal_data_manager.dart';
import 'package:ta_peersupervision/constants/colors.dart';

class APSReportTable extends StatelessWidget {
  final JadwalList jadwal;
  final VoidCallback onTap;
  final bool checkLaporan;

  const APSReportTable({
    super.key,
    required this.jadwal,
    required this.onTap, required this.checkLaporan,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        color: CustomColor.purpleBg2,
        child: ListTile(
          title: SelectableText('Inisial Dampingan: ${jadwal.initial}', style: const TextStyle( color: CustomColor.purpleTersier)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SelectableText("ID Dampingan: ${jadwal.reqid}", style: const TextStyle(fontWeight: FontWeight.bold, color: CustomColor.purpleTersier)),
              SelectableText("Nomor Jadwal: ${jadwal.jadwalid}"),
              SelectableText("Tanggal Pendampingan: ${jadwal.formattedTanggal}"),

              const SizedBox(height: 5),

              checkLaporan
              ? const SelectableText('Laporan pendampingan SUDAH terisi', style: TextStyle(color: Colors.green),)
              : const SelectableText('Laporan pendampingan BELUM terisi', style: TextStyle(color: Colors.red),)
            ],
          ),
          trailing: IconButton(
            icon: checkLaporan ? const Icon(Icons.info) : const Icon(Icons.edit),
            onPressed: onTap,
          ),
        ),
      ),
    );
  }
}
