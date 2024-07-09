// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ta_peersupervision/constants/colors.dart';

class MainMobile extends StatefulWidget {
  const MainMobile({super.key});

  @override
  _MainMobileState createState() => _MainMobileState();
}

class _MainMobileState extends State<MainMobile> {
  String? _psname;

  @override
  void initState() {
    super.initState();
    _loadPSUserName();
  }

  Future<void> _loadPSUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final psusersJson = prefs.getString('psusersJson');
    if (psusersJson != null) {
      final psusersData = jsonDecode(psusersJson);
      setState(() {
        _psname = psusersData['psname'];
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
          SelectableText(
            "Selamat Datang,\nPendamping Sebaya ITB\n${_psname ?? ''}",
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
                Get.toNamed('/ps-dampingan');
              },
              child: const Text(
                "Cek Dampingan Saya",
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
