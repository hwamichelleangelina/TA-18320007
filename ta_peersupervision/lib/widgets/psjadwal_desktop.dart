import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/widgets/list_button.dart';

class JadwalPSDesktop extends StatelessWidget {
  const JadwalPSDesktop({super.key});

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
                  title: 'Dampingan Saya',
                  imagePath: 'assets/images/Dampingan.png',
                  onPressed: () {
                    Get.toNamed('ps-dampingan');
                  },
                ),
                ListTileButton(
                  title: 'Buat Jadwal Pendampingan',
                  imagePath: 'assets/images/Penjadwalan.png', // Lokasi gambar
                  onPressed: () {
                    Get.toNamed('/ps-jadwal');
                  },
                ),
              ],
            ),
          ),
        ],
      );
  }
}