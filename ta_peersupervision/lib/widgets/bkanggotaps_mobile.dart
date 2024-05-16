import 'package:flutter/material.dart';
import 'package:ta_peersupervision/pages/anggota_page/bkdata_anggota_page.dart';
import 'package:ta_peersupervision/pages/anggota_page/bkeditdata_anggota.dart';
import 'package:ta_peersupervision/pages/anggota_page/bktambahdata_anggota.dart';
import 'package:ta_peersupervision/widgets/list_button.dart';

class BKAnggotaPSITBMobile extends StatelessWidget {
  const BKAnggotaPSITBMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return 
      // platform jadwal
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth-50,
            ),
            
            child: Wrap(
              spacing: 20.0,
              runSpacing: 20.0,
              alignment: WrapAlignment.center,

              children: [
                ListTileButton(
                  title: 'Tambah Anggota Baru',
                  imagePath: 'assets/images/Add Dampingan.png', // Lokasi gambar Anda
                  onPressed: () {
                    // Navigasi ke halaman tambahkan anggota baru
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BKTambahAnggota()),
                    );
                  },
                ),
                ListTileButton(
                  title: 'Lihat Anggota PS',
                  imagePath: 'assets/images/Member.png', // Lokasi gambar Anda
                  onPressed: () {
                    // Navigasi ke halaman lain untuk Button 2
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BKDataAnggota()),
                    );
                  },
                ),
                ListTileButton(
                  title: 'Perbarui Data Anggota',
                  imagePath: 'assets/images/Edit.png', // Lokasi gambar Anda
                  onPressed: () {
                    // Navigasi ke halaman lain untuk Button 2
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BKEditAnggota()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      );
  }
}