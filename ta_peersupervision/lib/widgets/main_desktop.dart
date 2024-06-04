// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/api/shared_preferences/psusers_data_manager.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:drop_shadow/drop_shadow.dart';

class MainDesktop extends StatefulWidget {
  const MainDesktop({super.key});

  @override
  _MainDesktopState createState() => _MainDesktopState();
}

class _MainDesktopState extends State<MainDesktop> {
  String? _psname;

  @override
  void initState() {
    super.initState();
    _loadPSUserName();
  }

  Future<void> _loadPSUserName() async {
    final psname = await PSUsersDataManager.getPSUserName();
    setState(() {
      _psname = psname;
    });
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
              Text(
                "Selamat Datang,\nPendamping Sebaya ITB\n${_psname ?? ''}",
                style: const TextStyle(
                  fontSize: 30.0,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                  color: CustomColor.purpleTersier,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 350.0,
                height: 50.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColor.purpleTersier,
                  ),
                  onPressed: () {
                    Get.toNamed('/ps-dampingan');
                  },
                  child: const Text(
                    "Cek Dampingan Saya Hari ini",
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
