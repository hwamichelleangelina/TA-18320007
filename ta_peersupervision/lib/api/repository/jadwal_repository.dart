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

  Future<Map<DateTime, List<MyJadwal>>> fetchJadwal(int psnim) async {
    final PSUsers? loggedInUser = await PSUsersDataManager.loadPSUsersData();

    if (loggedInUser != null) {
  //    print('PSNIM: ${loggedInUser.psnim}');
      psnim = loggedInUser.psnim;
    } else {
      throw Exception('No logged in user');
    }

    final response = await http.get(Uri.parse('$serverUrl/getJadwal/$psnim'));
  //  print('statusCode: ${response.statusCode}');
  //  print('Response body: ${response.body}'); // Tambahkan ini untuk memeriksa data JSON asli

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      if (data.containsKey('jadwal')) {
        List<dynamic> jadwalList = data['jadwal'];
        Map<DateTime, List<MyJadwal>> fetchedJadwal = {};

        for (var eventJson in jadwalList) {
          DateTime date;
          
          try {
            String dateString = eventJson['tanggalKonversi'].toString();
            // Parsing sebagai UTC dan konversi ke waktu lokal
            date = DateTime.parse(dateString).toLocal(); // Perbaiki di sini
            // Extract only the date part (ignoring the time part)
            date = DateTime(date.year, date.month, date.day);
  //          print('Parsed date: $date');
          } catch (e) {
            print('Error parsing date: $e');
            continue;
          }

          if (fetchedJadwal[date] == null) {
            fetchedJadwal[date] = [];
          }
          fetchedJadwal[date]!.add(MyJadwal.fromJson(eventJson));
        }

  //      print('Final fetchedJadwal: $fetchedJadwal');
        return fetchedJadwal;
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<void> deleteJadwal(int jadwalid) async {
    final response = await http.delete(
      Uri.parse('$serverUrl/deleteJadwal/$jadwalid'),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Hapus Jadwal Pendampingan', 'Jadwal pendampingan $jadwalid berhasil dihapus',
        backgroundColor: Colors.green,
        colorText: Colors.white,);
    } else if (response.statusCode == 500) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String message = responseData["message"];
      Get.snackbar('Hapus Jadwal Pendampingan', message,
        backgroundColor: Colors.red,
        colorText: Colors.white,);
    } else {
      Get.snackbar('Hapus Jadwal Pendampingan', "Failed to delete Dampingan",
        backgroundColor: Colors.red,
        colorText: Colors.white,);
    }
  }


  // untuk BK ITB
  Future<Map<DateTime, List<MyJadwal>>> fetchAllJadwal() async {
    final response = await http.get(Uri.parse('$serverUrl/getJadwal'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      Map<DateTime, List<MyJadwal>> fetchedJadwal = {};

      for (var eventJson in data) {
        DateTime date;

        try {
          String dateString = eventJson['tanggalKonversi'].toString();
          date = DateTime.parse(dateString).toLocal();
          date = DateTime(date.year, date.month, date.day);
        } catch (e) {
          print('Error parsing date: $e');
          continue;
        }

        if (fetchedJadwal[date] == null) {
          fetchedJadwal[date] = [];
        }
        fetchedJadwal[date]!.add(MyJadwal.fromJson(eventJson));
      }

      return fetchedJadwal;
    } else {
      throw Exception('Failed to load events');
    }
  }
}