// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/api/logic/laporan_logic.dart';

class LaporanRepository {
  String serverUrl = 'http://localhost:3000/laporan';

  Future<List<Laporan>> fetchLaporan() async {
    final response = await http.get(Uri.parse('$serverUrl/getLaporan'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final Laporan laporan = Laporan.fromJson(jsonData);
      return [laporan]; // Mengembalikan dalam bentuk list
    } else {
      throw Exception('Failed to load laporan');
    }
  }

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
}