// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/pages/dampingan_page/apsdampingan_page.dart';
import 'package:ta_peersupervision/pages/jadwal_page/apsjadwal_page.dart';
import 'package:ta_peersupervision/pages/req_entry_page/apsformentry_page.dart';
import 'package:ta_peersupervision/widgets/list_button.dart';

class APSJadwalDesktop extends StatefulWidget {
  const APSJadwalDesktop({super.key});

  @override
  _APSJadwalDesktopState createState() => _APSJadwalDesktopState();
}

class _APSJadwalDesktopState extends State<APSJadwalDesktop> {
  late double screenWidth;
  int psnim = 0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    screenWidth = screenSize.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: screenWidth - 50,
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
                title: 'Jadwal Pendampingan',
                imagePath: 'assets/images/Penjadwalan.png',
                onPressed: () {
                  Get.to(() => APSJadwalPage(psnim: psnim));
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
