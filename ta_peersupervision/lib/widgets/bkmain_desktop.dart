// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:ta_peersupervision/constants/colors.dart';

class BKMainDesktop extends StatefulWidget {
  const BKMainDesktop({super.key});

  @override
  _BKMainDesktopState createState() => _BKMainDesktopState();
}

class _BKMainDesktopState extends State<BKMainDesktop> {
  String? _bkname;

  @override
  void initState() {
    super.initState();
    _loadBKUserName();
  }

  Future<void> _loadBKUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final bkusersJson = prefs.getString('bkusersJson');
    if (bkusersJson != null) {
      final bkusersData = jsonDecode(bkusersJson);
      setState(() {
        _bkname = bkusersData['bkname'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Container(
      margin: const EdgeInsets.only(
        left: 70.0,
        top: 60.0,
        bottom: 60.0,
        right: 160.0,
      ),
      height: screenHeight / 1.4,
      constraints: const BoxConstraints(
        minHeight: 350.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectableText(
                "Selamat Datang,\nBimbingan Konseling ITB\n${_bkname ?? ''}",
                style: const TextStyle(
                  fontSize: 30.0,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                  color: CustomColor.purpleTersier,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 370.0,
                height: 50.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColor.purpleTersier,
                  ),
                  onPressed: () {
                    Get.toNamed('/bk-laporan');
                  },
                  child: const Text(
                    "Cek Laporan Pendampingan",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: CustomColor.purpleprimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          DropShadow(
            blurRadius: 20.0,
            color: Colors.black,
            opacity: 0.5,
            offset: const Offset(5.0, 10.0),
            child: Image.asset(
              "assets/images/PSlogo.png",
              width: screenWidth / 4,
            ),
          ),
        ],
      ),
    );
  }
}
