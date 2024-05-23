import 'package:flutter/widgets.dart';
import 'package:ta_peersupervision/pages/anggota_page/apsdata_anggota_page.dart';
import 'package:ta_peersupervision/pages/dampingan_page/apsdampingan_page.dart';
import 'package:ta_peersupervision/pages/login_page/pslogin_page.dart';
import 'package:ta_peersupervision/pages/report_list_page/apsreport_page.dart';

List<Widget> naviAPS = [
  const APSDampinganPage(),
  const APSReportPage(),
  const APSDataAnggota(),
  const PSLoginPage(),
];