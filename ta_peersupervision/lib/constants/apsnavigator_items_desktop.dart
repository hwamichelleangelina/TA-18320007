import 'package:flutter/widgets.dart';
import 'package:ta_peersupervision/pages/anggota_page/apsdata_anggota_page.dart';
import 'package:ta_peersupervision/pages/jadwal_page/apsjadwal_page.dart';
import 'package:ta_peersupervision/pages/login_page/pslogin_page.dart';
import 'package:ta_peersupervision/pages/report_list_page/apsreport_page.dart';

int psnim = 0;

List<Widget> naviAPSDesktop = [
  APSJadwalPage(psnim: psnim),
  const APSReportPage(),
  const APSDataAnggota(),
  const PSLoginPage(),
];