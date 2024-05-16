import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';

class LoginBKTitleDesktop extends StatelessWidget {
  const LoginBKTitleDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Masuk Akun Admin BK ITB",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 23,
        color: CustomColor.whiteSecondary,
      ),
    );
  }
}