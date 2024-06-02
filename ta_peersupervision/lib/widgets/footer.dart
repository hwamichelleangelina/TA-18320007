import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Divider(
            color: CustomColor.purpleTersier,
          ),
        ),


        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          width: double.maxFinite,
          alignment: Alignment.center,
          child: const Text(
            "Oleh 18320007 untuk EB4291 Tugas Akhir II",
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              color:  CustomColor.purpleTersier,
            ),
          ),
        ),
      ],
    );
  }
}