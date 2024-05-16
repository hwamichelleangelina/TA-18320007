import 'package:flutter/material.dart';

class MediaLinks extends StatelessWidget {
  const MediaLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: [
        InkWell(
          onTap: (){},
          child: Image.asset("WhatsApp.png", width: 28),
        ),
        InkWell(
          onTap: (){},
          child: Image.asset("Email.png", width: 28),
        ),
      ],
    );
  }
}