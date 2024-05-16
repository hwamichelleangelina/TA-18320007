import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';

class SiteLogo extends StatelessWidget {
  const SiteLogo({super.key, this.onTap, required this.naviHome,});
  final VoidCallback? onTap;
  final Widget naviHome;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => naviHome,
          )
        );
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