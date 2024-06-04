// ignore_for_file: library_private_types_in_public_api

import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:ta_peersupervision/constants/colors.dart';

class BKMainMobile extends StatefulWidget {
  const BKMainMobile({super.key});

  @override
  _BKMainMobileState createState() => _BKMainMobileState();
}

class _BKMainMobileState extends State<BKMainMobile> {
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

    return Container(
      padding: const EdgeInsets.all(16.0),
      constraints: const BoxConstraints(minHeight: 560.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          // avatar img
          DropShadow(
            blurRadius: 20.0,
            color: Colors.black,
            opacity: 0.5,
            offset: const Offset(5.0, 10.0),
            child: Image.asset(
              "assets/images/PSlogo.png",
              width: screenWidth / 3,
            ),
          ),
          // intro text
          Text(
            "Selamat Datang,\nBimbingan Konseling ITB\n${_bkname ?? ''}",
            style: const TextStyle(
              fontSize: 23.0,
              height: 1.5,
              fontWeight: FontWeight.bold,
              color: CustomColor.purpleTersier,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 250.0,
            height: 45.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColor.purpleTersier,
              ),
              onPressed: () {
                Get.toNamed('/bk-laporan');
              },
              child: const Text(
                "Laporan Pendampingan",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 14.0,
                  color: CustomColor.purpleprimary,
                ),
              ),
            ),
          ),
          //btn
        ],
      ),
    );
  }
}
