import 'package:flutter/widgets.dart';
import 'package:ta_peersupervision/pages/anggota_page/bktambahdata_anggota.dart';
import 'package:ta_peersupervision/pages/home_page/bkhome_page.dart';
import 'package:ta_peersupervision/pages/login_page/bklogin_page.dart';

List<Widget> anggotaNaviBK = [
  const BKTambahAnggota(),
  const BKHomePage(),
  const BKLoginPage(title: 'Login'),
];