import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
    this.controller,
    this.maxLines = 1,
    this.hintText,
  });
  final TextEditingController? controller;
  final int maxLines;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      controller: controller,
      maxLines: maxLines,

      style: const TextStyle(
        color: CustomColor.purpleprimary,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        filled: true,
        fillColor: CustomColor.whiteSecondary,
        focusedBorder: getInputBorder,
        enabledBorder: getInputBorder,
        border: getInputBorder,
        hintText: hintText,
        hintStyle: const TextStyle(color: CustomColor.hintDark,),

        suffix: InkWell(
          onTap: (){

          },
          child:
            const Icon(Icons.visibility,
            color: CustomColor.purpleSecondary,
            size: 20),
        ),

      ),
    );
  }

  OutlineInputBorder get getInputBorder{
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    );
  }

}