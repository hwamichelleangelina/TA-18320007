// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ta_peersupervision/api/provider/dampingan_provider.dart';
import 'package:ta_peersupervision/api/provider/laporan_provider.dart';
import 'package:ta_peersupervision/pages/splashscreen.dart';

void main() async {
  Get.testMode = true; // Mode testing aktif
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DampinganProvider()),
        ChangeNotifierProvider(create: (context) => LaporanProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Montserrat',
        ),
        title: 'Pengawasan PS ITB',
        home: const SplashScreen(),
      ),
    );
  }
}