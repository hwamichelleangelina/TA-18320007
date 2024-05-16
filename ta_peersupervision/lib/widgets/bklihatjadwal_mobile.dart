import 'package:flutter/material.dart';
import 'package:ta_peersupervision/pages/jadwal_page/bkjadwal_page.dart';
import 'package:ta_peersupervision/widgets/list_button.dart';

class BKJadwalMobile extends StatelessWidget {
  const BKJadwalMobile({super.key});

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
                  title: 'Lihat Jadwal Pendampingan',
                  imagePath: 'assets/images/Penjadwalan.png', // Lokasi gambar Anda
                  onPressed: () {
                    // Navigasi ke halaman tambahkan anggota baru
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BKJadwalPage()),
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