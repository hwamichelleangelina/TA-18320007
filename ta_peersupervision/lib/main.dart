// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ta_peersupervision/pages/splashscreen.dart';

void main() async {
  Get.testMode = true; // Mode testing aktif
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Montserrat',
      ),
      title: 'Pengawasan PS ITB',
      home: const SplashScreen(),
    );
  }
}