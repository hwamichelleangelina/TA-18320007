import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ta_peersupervision/api/logic/psusers_logic.dart';
import 'package:ta_peersupervision/api/shared_preferences/psusers_data_manager.dart';

class ReqidStorage {
  static int reqid = 0;

  static void setReqid(int value) {
    reqid = value;
  }

  static int getReqid() {
    return reqid;
  }
}

// lib/models/jadwal.dart
class JadwalList {
  final int jadwalid;
  final int reqid;
  final String initial;
  final DateTime tanggal;

  JadwalList({
    required this.jadwalid,
    required this.reqid,
    required this.initial,
    required this.tanggal,
  });

  factory JadwalList.fromJson(Map<String, dynamic> json) {
    return JadwalList(
      jadwalid: json['jadwalid'],
      reqid: json['reqid'],
      initial: json['initial'],
      tanggal: json['tanggal'],
    );
  }
}

class JadwalService {
  static Future<List<JadwalList>> fetchJadwalReports() async {
    final PSUsers? loggedInUser = await PSUsersDataManager.loadPSUsersData();
    int psnim;

    if (loggedInUser != null) {
        psnim = loggedInUser.psnim;
    } else {
      throw Exception('No logged in user');
    }

    final response = await http.get(Uri.parse('http://localhost:3000/laporan/getJadwal/$psnim'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => JadwalList.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load jadwal for reports');
    }
  }
}
