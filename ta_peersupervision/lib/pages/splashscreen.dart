// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/api/logic/psusers_logic.dart';
import 'package:ta_peersupervision/api/shared_preferences/bkusers_data_manager.dart';
import 'package:ta_peersupervision/api/shared_preferences/psusers_data_manager.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/size.dart';
import 'package:ta_peersupervision/pages/home_page/apshome_page.dart';
import 'package:ta_peersupervision/pages/home_page/bkhome_page.dart';
import 'package:ta_peersupervision/pages/home_page/pshome_page.dart';
import 'package:ta_peersupervision/pages/login_page/pslogin_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isBKLoggedIn = false;
  bool isPSLoggedIn = false;
  Future<void> setDetails() async {
    isBKLoggedIn = await BKUsersDataManager.hasBKUsersData();
    isPSLoggedIn = await PSUsersDataManager.hasPSUsersData();
  }

  // Buat if PSLoggedIn akan masuk ke PSHomePage, else if BKLoggedIn masuk ke BKHomePage

  @override
  void initState() {
    super.initState();
    // Lakukan sesuatu saat splash screen muncul, misalnya, inisialisasi data
    setDetails();

    Timer(
      const Duration(seconds: 3),
      () async {
        if (isBKLoggedIn) {
          Get.snackbar('Bimbingan Konseling ITB', 'You are logged in',
              backgroundColor: Colors.green,
              colorText: Colors.white,);
          Get.to(()=> const BKHomePage());
        }
        else if (isPSLoggedIn) {
          PSUsers? psUser = await PSUsersDataManager.loadPSUsersData();

          if (psUser?.psisAdmin == 1) {
            // Jika pengguna adalah admin, navigasi ke APSHomePage
            Get.snackbar('Pendamping Sebaya ITB', 'You are logged in as Kepala Divisi Kuratif',
              backgroundColor: Colors.green,
              colorText: Colors.white,);
            Get.to(() => const APSHomePage());
          }
          else {
            // Jika pengguna adalah member, navigasi ke PSHomePage
            Get.snackbar('Pendamping Sebaya ITB', 'You are logged in',
              backgroundColor: Colors.green,
              colorText: Colors.white,);
            Get.to(() => const PSHomePage());
          }
        }
        else {
          Get.to(()=> const PSLoginPage());
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.purpleBg2,
      body: Stack(
        children: <Widget> [ 
            Image.asset('assets/images/PSLogo.png', 
              width: double.infinity/2, 
              height: double.infinity/2, 
              fit:BoxFit.cover,),
            Center (
              child: Container(
                  width: minDesktopWidth/3,
                  height: minDesktopWidth/6,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(color: CustomColor.purpleBg),
                  child: 
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Peer ITB Supervision\nBimbingan Konseling ITB',
                        style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      Text('Made by 18320007',
                        style: TextStyle(fontSize: 15)),
                    ],
                  ),
              ),
            )
        ]
      ),
    );
  }
}