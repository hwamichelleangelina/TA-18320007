import 'package:flutter/widgets.dart';
import 'package:ta_peersupervision/pages/anggota_page/bkdata_anggota_page.dart';
import 'package:ta_peersupervision/pages/login_page/bklogin_page.dart';
import 'package:ta_peersupervision/pages/report_list_page/bkreport_page.dart';
import 'package:ta_peersupervision/pages/statistik_page/bkstatistik_page.dart';

List<Widget> naviBK = [
  const StatistikPS(),
  const BKCekLaporan(),
  const BKDataAnggota(),
  const BKLoginPage(title: 'Login'),
];