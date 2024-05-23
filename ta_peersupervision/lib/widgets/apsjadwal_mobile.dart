import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/pages/dampingan_page/apsdampingan_page.dart';
import 'package:ta_peersupervision/pages/jadwal_page/apsjadwal_page.dart';
import 'package:ta_peersupervision/pages/req_entry_page/apsformentry_page.dart';
import 'package:ta_peersupervision/widgets/list_button.dart';

class APSJadwalMobile extends StatelessWidget {
  const APSJadwalMobile({super.key});

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
                  title: 'Permintaan Pendampingan',
                  imagePath: 'assets/images/Form Entry.png',
                  onPressed: () {
                    Get.to(() => const APSFormEntry());
                  },
                ),
                ListTileButton(
                  title: 'Cek Jadwal Pendampingan',
                  imagePath: 'assets/images/Penjadwalan.png', // Lokasi gambar Anda
                  onPressed: () {
                    // Navigasi ke halaman lain untuk Button 2
                    Get.to(() => const APSJadwalPage());
                  },
                ),
                ListTileButton(
                  title: 'Dampingan Saya',
                  imagePath: 'assets/images/Dampingan.png',
                  onPressed: () {
                    Get.to(() => const APSDampinganPage());
                  },
                ),
              ],
            ),
          ),
        ],
      );
  }
}