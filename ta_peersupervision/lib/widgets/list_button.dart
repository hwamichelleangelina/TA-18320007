import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';


class ListTileButton extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onPressed;

  const ListTileButton({
    required this.title,
    required this.imagePath,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 30.0), // Padding kiri dan kanan
        width: screenWidth * 0.6, // Lebar container (80% dari lebar layar)
        decoration: BoxDecoration(
          color: CustomColor.purpleTersier,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 15.0),
              Image.asset(
                imagePath,
                width: 27.0, // Lebar gambar
                height: 27.0, // Tinggi gambar
              ),
              const SizedBox(height: 10.0), // Spacer antara gambar dan teks
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      )
    );
  }
}
