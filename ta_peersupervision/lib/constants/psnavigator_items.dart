import 'package:flutter/widgets.dart';
import 'package:ta_peersupervision/pages/jadwal_page/psjadwal_page.dart';
import 'package:ta_peersupervision/pages/login_page/pslogin_page.dart';
import 'package:ta_peersupervision/pages/report_list_page/psreport_page.dart';

int psnim = 0;

List<Widget> naviPS = [
  PSJadwalPage(psnim: psnim),
  const PSReportPage(),
  const PSLoginPage(),
];