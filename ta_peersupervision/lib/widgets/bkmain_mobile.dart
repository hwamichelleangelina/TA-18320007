import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/pages/report_list_page/bkreport_page.dart';

class BKMainMobile extends StatelessWidget {
  const BKMainMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Container(
        height: screenHeight/1.5,
        constraints: const BoxConstraints(minHeight: 560.0),
        child: Column(
          /*
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          */
          children: [
            const SizedBox(height: 20),
            // avatar img
              DropShadow(
                blurRadius: 20.0,
                color: Colors.black,
                opacity: 0.5,
                offset: const Offset(5.0,10.0),
                child: Image.asset(
                "assets/images/PSlogo.png",
                width: screenWidth/4,
                ),
              ),

            // intro text
            const Text(
              "Selamat Datang,\nBimbingan Konseling ITB",
              style: TextStyle(
                fontSize: 23.0,
                height: 1.5,
                fontWeight: FontWeight.bold,
                color: CustomColor.purpleTersier,
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: 250.0,
              height: 45.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColor.purpleTersier,
                ),
                onPressed: (){
                  Get.to(() => const BKCekLaporan());
                },
                child: const Text(
                  "Laporan Pendampingan",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 14.0,
                    color: CustomColor.purpleprimary,
                  ),
                ),
              ),
            ),
            //btn
          ],
        ),
      );
  }
}