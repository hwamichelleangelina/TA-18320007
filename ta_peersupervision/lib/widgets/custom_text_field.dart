import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.maxLines = 1,
    required this.hintText,
    required this.obscureText,
  });
  final TextEditingController? controller;
  final int maxLines;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      obscureText: obscureText,

      style: const TextStyle(
        color: CustomColor.purpleprimary,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        filled: true,
        fillColor: CustomColor.whiteSecondary,
        focusedBorder: getInputFBorder,
        enabledBorder: getInputEBorder,
        border: getInputEBorder,
        hintText: hintText,
        hintStyle: const TextStyle(color: CustomColor.hintDark,),
      ),
    );
  }

  OutlineInputBorder get getInputFBorder{
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color.fromARGB(255, 0, 133, 228)),
    );
  }

  OutlineInputBorder get getInputEBorder{
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    );
  }

}