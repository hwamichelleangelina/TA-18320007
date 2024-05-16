import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';

class RegisterBKTitleDesktop extends StatelessWidget {
  const RegisterBKTitleDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Daftarkan Admin BK ITB",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 23,
        color: CustomColor.whiteSecondary,
      ),
    );
  }
}