import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ta_peersupervision/api/logic/psusers_logic.dart';
import 'package:ta_peersupervision/api/shared_preferences/jadwal_data_manager.dart';
import 'package:ta_peersupervision/api/shared_preferences/psusers_data_manager.dart';

class LaporanProvider with ChangeNotifier {
  final String serverUrl = 'http://localhost:3000/laporan';

  LaporanProvider() {
    fetchJadwalReport();
  }

  // fetch jadwal

Future<List<JadwalList>> fetchJadwalReport() async {
    final PSUsers? loggedInUser = await PSUsersDataManager.loadPSUsersData();
    int psnim;

    if (loggedInUser != null) {
        psnim = loggedInUser.psnim;
    } else {
      throw Exception('No logged in user');
    }

    final response = await http.get(Uri.parse('http://localhost:3000/laporan/getJadwal/$psnim'));

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
          notifyListeners();
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

  late bool _checkLaporan;

  bool get checkLaporan => _checkLaporan;

  Future<bool> fetchCheckLaporan(int jadwalid) async {
    final response = await http.get(Uri.parse('http://localhost:3000/laporan/isLaporanFilled/$jadwalid/'));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result['hasReported'];
    } else {
      throw Exception('Failed to check report');
    }
  }
}