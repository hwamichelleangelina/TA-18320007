import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';

class LoginTitleDesktop extends StatelessWidget {
  const LoginTitleDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Masuk Akun Pendamping Sebaya ITB",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 23,
        color: CustomColor.whiteSecondary,
      ),
    );
  }
}