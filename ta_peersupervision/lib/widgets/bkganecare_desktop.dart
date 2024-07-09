import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/widgets/list_button.dart';

class BKGanecareITB extends StatelessWidget {
  const BKGanecareITB({super.key});

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
                  title: 'Kegiatan dalam Ganecare',
                  imagePath: 'assets/images/Ganecare.png',
                  onPressed: () {
                    Get.toNamed('/bk-ganecare');
                  },
                ),
              ],
            ),
          ),
        ],
      );
  }
}