import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/pages/psubah_password.dart';

class ResetPSPassword extends StatelessWidget {
  const ResetPSPassword({super.key});

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
                ElevatedButton(
                  child: const Text(
                    "Ubah Password",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ), onPressed: () {
                    Get.to(() => const UbahPSPassword());
                  },
                ),
              ],
            ),
          ),
        ],
      );
  }
}