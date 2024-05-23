// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/api/logic/jadwal_logic.dart';
import 'package:ta_peersupervision/api/logic/psusers_logic.dart';
import 'package:ta_peersupervision/api/repository/event.dart';
import 'package:ta_peersupervision/api/shared_preferences/psusers_data_manager.dart';

class JadwalRepository {
  String serverUrl = 'http://localhost:3000/jadwal';

  Future<void> createJadwal({required Jadwal jadwal}) async {
    final response = await http.post(
      Uri.parse('$serverUrl/createJadwal'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'reqid': jadwal.reqid,
        'tanggal': jadwal.tanggal, // Ensure the date is in the correct format
        'mediapendampingan': jadwal.mediapendampingan
      }),
    );

//      print(jadwal.tanggal.runtimeType);
//      print(jadwal.tanggal);
//      print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar('Rencanakan jadwal Pendampingan', 'Pendampingan berhasil dijadwalkan',
        backgroundColor: Colors.green, colorText: Colors.white); 
//      print('Selected Date Dampingan Repo: ${DateFormat('yyyy-MM-dd').format(jadwalPendampingan.tanggal!)}');
//      print(DateFormat('yyyy-MM-dd').format(jadwalPendampingan.tanggal!).runtimeType);
//      final Map<String, dynamic> responseData = jsonDecode(response.body);
//      final String message = responseData["message"];
//      Get.snackbar('Jadwalkan Pendampingan', message,
//        backgroundColor: Colors.green,
//        colorText: Colors.white,);
    } else if (response.statusCode == 500) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String message = responseData["message"];
      Get.snackbar('Jadwalkan Pendampingan', message,
        backgroundColor: Colors.red,
        colorText: Colors.white,);
    } else {
      Get.snackbar('Jadwalkan Pendampingan', "Failed to schedule pendampingan",
        backgroundColor: Colors.red,
        colorText: Colors.white,);
    }
  }

  Future<Map<DateTime, List<MyJadwal>>> fetchJadwal(int? psnim) async {
    final PSUsers? loggedInUser = await PSUsersDataManager.loadPSUsersData();

    if (loggedInUser != null) {
        // print(loggedInUser.psnim);
        psnim = loggedInUser.psnim;
      //  print('async fetchDampingan: $psnim');
    } else {
      throw Exception('No logged in user');
    }

    final response = await http.get(Uri.parse('$serverUrl/getEvents'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      Map<DateTime, List<MyJadwal>> fetchedJadwal = {};

      for (var eventJson in data) {
        MyJadwal jadwal = MyJadwal.fromJson(eventJson);
        DateTime date = DateTime(jadwal.tanggal.year, jadwal.tanggal.month, jadwal.tanggal.day);
        if (fetchedJadwal[date] == null) {
          fetchedJadwal[date] = [];
        }
        fetchedJadwal[date]!.add(jadwal);
      }

      return fetchedJadwal;
    } else {
      throw Exception('Failed to load events');
    }
  }
}