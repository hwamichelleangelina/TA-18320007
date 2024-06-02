// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/widgets/list_button.dart';

class APSJadwalMobile extends StatefulWidget {
  const APSJadwalMobile({super.key});

  @override
  _APSJadwalMobileState createState() => _APSJadwalMobileState();
}

class _APSJadwalMobileState extends State<APSJadwalMobile> {
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
                  Get.toNamed('/aps-dampingan-entry');
                },
              ),
              ListTileButton(
                title: 'Dampingan Saya',
                imagePath: 'assets/images/Dampingan.png',
                onPressed: () {
                  Get.toNamed('/aps-dampingan');
                },
              ),
              ListTileButton(
                title: 'Jadwal Pendampingan',
                imagePath: 'assets/images/Penjadwalan.png',
                onPressed: () {
                  Get.toNamed('/aps-jadwal');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
