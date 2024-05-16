import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';

class LoginBKTitleMobile extends StatelessWidget {
  const LoginBKTitleMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: const Text(
        "Masuk Akun Admin BK ITB",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: CustomColor.whiteSecondary,
        ),
      ),
    );
  }
}