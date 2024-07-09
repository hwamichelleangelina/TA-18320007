// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:ta_peersupervision/api/logic/psusers_logic.dart';
import 'package:ta_peersupervision/api/provider/dampingan_provider.dart';
import 'package:ta_peersupervision/api/provider/laporan_provider.dart';
import 'package:ta_peersupervision/api/shared_preferences/bkusers_data_manager.dart';
import 'package:ta_peersupervision/api/shared_preferences/psusers_data_manager.dart';
import 'package:ta_peersupervision/pages/anggota_page/apsdata_anggota_page.dart';
import 'package:ta_peersupervision/pages/anggota_page/bkdata_anggota_page.dart';
import 'package:ta_peersupervision/pages/anggota_page/bkeditdata_anggota.dart';
import 'package:ta_peersupervision/pages/anggota_page/bktambahdata_anggota.dart';
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
import 'package:ta_peersupervision/pages/req_entry_page/apsnewformentry_page.dart';
import 'package:ta_peersupervision/pages/splashscreen.dart';
import 'package:ta_peersupervision/pages/statistik_page/bkstatistik_page.dart';
import 'package:ta_peersupervision/pages/ubah_password/psubah_password.dart';
import 'package:ta_peersupervision/pages/ubah_password/ubah_password.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id', null);
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
      child: FutureBuilder<bool>(
        future: _isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            ); // Menampilkan loading jika data belum siap
          } else if (snapshot.hasError) {
            return MaterialApp(
              home: Scaffold(
                body: Center(child: SelectableText('Error: ${snapshot.error}')),
              ),
            ); // Menampilkan pesan error jika ada
          } else {
            bool isLoggedIn = snapshot.data ?? false;
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                brightness: Brightness.dark,
                fontFamily: 'Montserrat',
              ),
              initialRoute: isLoggedIn ? '/' : '/ps-login',
              getPages: [
                GetPage(name: '/', page: () => const SplashScreen()),
                // BK
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

                // PS
                GetPage(name: '/ps-login', page: () => const PSLoginPage()),
                GetPage(name: '/aps-login', page: () => const PSLoginPage()),
                GetPage(name: '/ps-ubah-password', page: () => const UbahPSPassword()),
                GetPage(name: '/aps-home', page: () => const APSHomePage()),
                GetPage(name: '/ps-home', page: () => const PSHomePage()),
                GetPage(name: '/aps-requests', page: () => const APSFormEntry()),
                GetPage(name: '/aps-dampingan', page: () => const APSDampinganPage()),
                GetPage(name: '/ps-dampingan', page: () => const PSDampinganPage()),
                GetPage(name: '/ps-jadwal', page: () => const PSJadwalPage(psnim: 0)),
                GetPage(name: '/aps-jadwal', page: () => const APSJadwalPage(psnim: 0)),
                GetPage(name: '/ps-laporan', page: () => const PSReportPage()),
                GetPage(name: '/aps-laporan', page: () => const APSReportPage()),
                GetPage(name: '/aps-anggota-ps', page: () => const APSDataAnggota()),
                GetPage(name: '/aps-dampingan-entry', page: () => const DampinganFormPage()),
                GetPage(name: '/aps-new-entry', page: () => const APSNewFormEntry()),
              ],
              navigatorObservers: [GetObserver()],
              routingCallback: (routing) {
                if (routing?.current != null && routing?.isBack == false) {
                  final String path = routing!.current;
                  //print("Routing ke: $path");
                  _handleRedirects(path);
                }
              },
            );
          }
        },
      ),
    );
  }

  Future<bool> _isLoggedIn() async {
    bool isBKLoggedIn = await BKUsersDataManager.hasBKUsersData();
    bool isPSLoggedIn = await PSUsersDataManager.hasPSUsersData();
    return isBKLoggedIn || isPSLoggedIn;
  }

  void _handleRedirects(String path) async {
    bool isBKLoggedIn = await BKUsersDataManager.hasBKUsersData();
    bool isPSLoggedIn = await PSUsersDataManager.hasPSUsersData();
    PSUsers? psUser = await PSUsersDataManager.loadPSUsersData();

    // Routes that require BK login
    final List<String> bkRoutes = [
      '/bk-home',
      '/bk-laporan',
      '/bk-jadwal',
      '/bk-anggota-ps',
      '/bk-stats',
      '/bk-ubah-password',
      '/bk-tambah-anggota',
      '/bk-edit-anggota',
    ];

    // Routes that require PS login
    final List<String> psRoutes = [
      '/ps-home',
      '/ps-dampingan',
      '/ps-jadwal',
      '/ps-laporan',
      '/ps-ubah-password',
    ];

    final List<String> apsRoutes = [
      '/aps-home',
      '/aps-requests',
      '/aps-dampingan',
      '/aps-jadwal',
      '/aps-laporan',
      '/aps-anggota-ps',
      '/aps-dampingan-entry',
      '/ps-ubah-password',
      '/aps-new-entry',
    ];

    // Common login page routes
    final List<String> loginRoutes = [
      '/ps-login',
      '/bk-login',
      '/aps-login',
      '/bk-register'
    ];

    // Redirect logic
    if (!isBKLoggedIn && !isPSLoggedIn && bkRoutes.contains(path)) {
      //print("Not logged in and trying to access BK page $path. Redirecting to /bk-login");
      Future.microtask(() => Get.offNamed('/bk-login'));
    } else if (!isPSLoggedIn && !isBKLoggedIn && (psRoutes.contains(path) || apsRoutes.contains(path))) {
      //print("Not logged in and trying to access PS page $path. Redirecting to /ps-login");
      Future.microtask(() => Get.offNamed('/ps-login'));

    }  else if (isPSLoggedIn && (psUser?.psisAdmin == 0) && (bkRoutes.contains(path) || apsRoutes.contains(path))) {
      //print("PS logged in and trying to access BK or Admin PS page $path. Redirecting to /ps-home");
      Future.microtask(() => Get.offNamed('/ps-home'));
    }  else if (isPSLoggedIn && (psUser?.psisAdmin == 1) && (bkRoutes.contains(path) || psRoutes.contains(path))) {
      //print("PS logged in and trying to access BK or PS page $path. Redirecting to /aps-home");
      Future.microtask(() => Get.offNamed('/aps-home'));
    }  else if (isBKLoggedIn && (psRoutes.contains(path) || apsRoutes.contains(path))) {
      //print("PS logged in and trying to access PS page $path. Redirecting to /bk-home");
      Future.microtask(() => Get.offNamed('/bk-home'));

    } else if (isBKLoggedIn && path == '/bk-login') {
      //print("BK logged in and trying to access login page /bk-login and not yet logged out. Redirecting to /bk-home");
      Future.microtask(() => Get.offNamed('/bk-home'));
    } else if (isPSLoggedIn && path == '/ps-login') {
      if (psUser?.psisAdmin == 1) {
        //print("Admin PS logged in and trying to access login page /ps-login and not yet logged out. Redirecting to /aps-home");
        Future.microtask(() => Get.offNamed('/aps-home'));
      } else {
        //print("PS logged in and trying to access login page /ps-login and not yet logged out. Redirecting to /ps-home");
        Future.microtask(() => Get.offNamed('/ps-home'));
      }

    } else if ((!isBKLoggedIn && !isPSLoggedIn) && !loginRoutes.contains(path)) {
      // If the user is not logged in and trying to access any page other than login
      //print("Not logged in and trying to access a protected page. Redirecting to /ps-login");
      Future.microtask(() => Get.offNamed('/ps-login'));
    }
  }
}