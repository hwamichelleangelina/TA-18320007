import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
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
  int? jadwalid;
  int? reqid;
  String? initial;
  int? psnim;
  DateTime? tanggal;
  String? psname;
  String? mediapendampingan;
  String? katakunci;
  DateTime? tanggalKonversi;

  JadwalList({
    required this.jadwalid,
    required this.reqid,
    required this.initial,
    this.psnim,
    required this.tanggal,
    this.psname,
    this.mediapendampingan,
    this.katakunci,
    required this.tanggalKonversi
  });

  factory JadwalList.fromJson(Map<String, dynamic> json) {
    return JadwalList(
      jadwalid: json['jadwalid'],
      reqid: json['reqid'],
      initial: json['initial'],
      tanggal: DateTime.parse(json['tanggal']),
      psnim: json['psnim'],
      psname: json['psname'],
      mediapendampingan: json['mediapendampingan'],
      katakunci: json['katakunci'],
      tanggalKonversi: DateTime.parse(json['tanggalKonversi']),
    );
  }

  String get formattedTanggal {
    final DateFormat formatter = DateFormat('d MMMM y');
    return formatter.format(tanggalKonversi!);
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

    final response = await http.get(Uri.parse('https://ta-peersupervision-server.vercel.app/laporan/getJadwal/$psnim'));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      // Tambahkan log untuk memeriksa format respons JSON
      //print("Respons JSON: $body");
      //print("Type of body: ${body.runtimeType}");

      // Jika body adalah Map, ambil daftar dari kunci yang sesuai
      if (body is Map<String, dynamic>) {
        if (body.containsKey('laporan')) {  // Menggunakan kunci 'laporan'
          List<dynamic> data = body['laporan'];
          List<JadwalList> jadwalList = data.map((dynamic item) => JadwalList.fromJson(item)).toList();
          return jadwalList;
        } else {
          throw Exception('Key not found in JSON');
        }
      } else if (body is List<dynamic>) {
        List<JadwalList> jadwalList = body.map((dynamic item) => JadwalList.fromJson(item)).toList();
        return jadwalList;
      } else {
        throw Exception('Unexpected JSON format');
      }
    } else {
      throw Exception('Failed to load jadwal');
    }
  }
}