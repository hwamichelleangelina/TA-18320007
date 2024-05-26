// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/api/logic/laporan_logic.dart';

class LaporanRepository {
  String serverUrl = 'http://localhost:3000/laporan';

  Future<void> fillLaporan({required Laporan laporan}) async {
    final response = await http.post(
      Uri.parse('$serverUrl/fillLaporan'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'jadwalid': laporan.jadwalid,
        'isRecommended': laporan.isRecommended, // Ensure the date is in the correct format
        'isAgree': laporan.isAgree,
        'gambaran': laporan.gambaran,
        'hasil': laporan.hasil,
        'kendala': laporan.kendala,
        'proses': laporan.proses
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar('Pengisian Laporan Pendampingan', 'Laporan pendampingan dengan Nomor Jadwal: ${laporan.jadwalid} berhasil disimpan',
        backgroundColor: Colors.green,
        colorText: Colors.white,); 
    } else if (response.statusCode == 500) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String message = responseData["message"];
      Get.snackbar('Isi Laporan Pendampingan', message,
        backgroundColor: Colors.red,
        colorText: Colors.white,);
    } else {
      Get.snackbar('Isi Laporan Pendampingan', "Failed to create laporan",
        backgroundColor: Colors.red,
        colorText: Colors.white,);
    }
  }

/*  Future<Map<DateTime, List<Laporan>>> fetchLaporan(int psnim) async {
    final PSUsers? loggedInUser = await PSUsersDataManager.loadPSUsersData();

    if (loggedInUser != null) {
        psnim = loggedInUser.psnim;
    } else {
      throw Exception('No logged in user');
    }

    final response = await http.get(Uri.parse('$serverUrl/getLaporan/$psnim'));
    print('statusCode: ${response.statusCode}');

    if (response.statusCode == 200) {
  //    List<dynamic> data = json.decode(response.body);
  //    Map<DateTime, List<MyJadwal>> fetchedJadwal = {};
      Map<String, dynamic> data = jsonDecode(response.body);

      Map<DateTime, List<MyJadwal>> fetchedJadwal = {};

      data.forEach((key, value) {
        // Parse date string with specified format
        DateTime date;
        print('value: $value');
        print('data: $data');
        try {
          date = DateTime.parse(data['tanggal']);
        } catch (e) {
            print('Error parsing date: $e');
            // Handle error case or use a default date
            // For example: date = DateTime.now();
            return;
          }
          fetchedJadwal[date] = (value as List).map((event) => MyJadwal.fromJson(event)).toList();

//        MyJadwal jadwal = MyJadwal.fromJson(eventJson);
//        DateTime date = DateTime(jadwal.tanggal.year, jadwal.tanggal.month, jadwal.tanggal.day);
//        if (fetchedJadwal[date] == null) {
//          fetchedJadwal[date] = [];
//        }
//        fetchedJadwal[date]!.add(jadwal);
      });

      return fetchLaporan;
    } else {
      throw Exception('Failed to load events');
    }
  }*/
}