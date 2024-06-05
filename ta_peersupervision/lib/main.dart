// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ta_peersupervision/api/provider/dampingan_provider.dart';
import 'package:ta_peersupervision/api/provider/laporan_provider.dart';
import 'package:ta_peersupervision/pages/anggota_page/apsdata_anggota_page.dart';
import 'package:ta_peersupervision/pages/anggota_page/bkdata_anggota_page.dart';
import 'package:ta_peersupervision/pages/anggota_page/bkeditdata_anggota.dart';
import 'package:ta_peersupervision/pages/anggota_page/bktambahdata_anggota.dart';
import 'package:ta_peersupervision/pages/bk_only/bkganecare_page.dart';
import 'package:ta_peersupervision/pages/bk_only/bkregister_page.dart';
import 'package:ta_peersupervision/pages/dampingan_page/apsdampingan_page.dart';
import 'package:ta_peersupervision/pages/dampingan_page/psdampingan_page.dart';
import 'package:ta_peersupervision/pages/home_page/apshome_page.dart';
import 'package:ta_peersupervision/pages/home_page/bkhome_page.dart';
import 'package:ta_peersupervision/pages/home_page/pshome_page.dart';
import 'package:ta_peersupervision/pages/jadwal_page/apsjadwal_page.dart';
import 'package:ta_peersupervision/pages/jadwal_page/bkjadwal_page.dart';
import 'package:ta_peersupervision/pages/jadwal_page/psjadwal_page.dart';
import 'package:ta_peersupervision/pages/login_page/bklogin_page.dart';
import 'package:ta_peersupervision/pages/login_page/pslogin_page.dart';
import 'package:ta_peersupervision/pages/report_list_page/apsreport_page.dart';
import 'package:ta_peersupervision/pages/report_list_page/bkreport_page.dart';
import 'package:ta_peersupervision/pages/report_list_page/psreport_page.dart';
import 'package:ta_peersupervision/pages/req_entry_page/apsformentry_edit_page.dart';
import 'package:ta_peersupervision/pages/req_entry_page/apsformentry_page.dart';
import 'package:ta_peersupervision/pages/splashscreen.dart';
import 'package:ta_peersupervision/pages/statistik_page/bkstatistik_page.dart';
import 'package:ta_peersupervision/pages/ubah_password/psubah_password.dart';
import 'package:ta_peersupervision/pages/ubah_password/ubah_password.dart';

void main() async {
  Get.testMode = true; // Mode testing aktif
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    int psnim = 0;

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
        initialRoute: '/', // Rute awal
        getPages: [
          // BK
          GetPage(name: '/', page: () => const SplashScreen()),
          GetPage(name: '/bk-laporan', page: () => const BKCekLaporan()),
          GetPage(name: '/bk-home', page: () => const BKHomePage()),
          GetPage(name: '/bk-jadwal', page: () => const BKJadwalPage()),
          GetPage(name: '/bk-anggota-ps', page: () => const BKDataAnggota()),
          GetPage(name: '/bk-stats', page: () => const StatistikPS()),
          GetPage(name: '/bk-ubah-password', page: () => const UbahBKPassword()),
          GetPage(name: '/bk-login', page: () => const BKLoginPage(title: 'Login')),
          GetPage(name: '/bk-register', page: () => const BKRegisterPage(title: 'Register User')),
          GetPage(name: '/bk-tambah-anggota', page: () => const BKTambahAnggota()),
          GetPage(name: '/bk-edit-anggota', page: () => const BKEditAnggota()),
          GetPage(name: '/bk-ganecare', page: () => BKGanecarePage()),

          // PS
          GetPage(name: '/ps-login', page: () => const PSLoginPage()),
          GetPage(name: '/aps-login', page: () => const PSLoginPage()),
          GetPage(name: '/ps-ubah-password', page: () => const UbahPSPassword()),
          GetPage(name: '/aps-home', page: () => const APSHomePage()),
          GetPage(name: '/ps-home', page: () => const PSHomePage()),
          GetPage(name: '/aps-requests', page: () => const APSFormEntry()),
          GetPage(name: '/aps-dampingan', page: () => const APSDampinganPage()),
          GetPage(name: '/ps-dampingan', page: () => const PSDampinganPage()),
          GetPage(name: '/ps-jadwal', page: () => PSJadwalPage(psnim: psnim)),
          GetPage(name: '/aps-jadwal', page: () => APSJadwalPage(psnim: psnim)),
          GetPage(name: '/ps-laporan', page: () => const PSReportPage()),
          GetPage(name: '/aps-laporan', page: () => const APSReportPage()),
          GetPage(name: '/aps-anggota-ps', page: () => const APSDataAnggota()),
          GetPage(name: '/aps-dampingan-entry', page: () => const DampinganFormPage()),
        ],
      ),
    );
  }
}