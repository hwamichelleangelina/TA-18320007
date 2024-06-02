import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/constants/colors.dart';

class APSSiteLogo extends StatelessWidget {
  const APSSiteLogo({super.key, this.onTap,});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/aps-home');
      },
      child:
      const DropShadow(
        blurRadius: 3.0,
        color: Colors.black,
        opacity: 0.5,
        offset: Offset(0.0, 2.0),
        child: Text("Peer Supervision",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: CustomColor.purpleTersier,
          ),
        ),
      ),
    );
  }
}