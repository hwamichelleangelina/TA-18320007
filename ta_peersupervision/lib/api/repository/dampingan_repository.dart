// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/api/logic/dampingan_logic.dart';
import 'package:ta_peersupervision/api/logic/psusers_logic.dart';
import 'package:ta_peersupervision/api/shared_preferences/psusers_data_manager.dart';

class DampinganRepository {
  final String serverUrl = 'http://localhost:3000/dampingan';

  Future<void> importDampingan({required Dampingan dampingan}) async {
    final response = await http.post(
      Uri.parse('$serverUrl/createDampingan'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'initial': dampingan.initial,
        'fakultas': dampingan.fakultas,
        'gender': dampingan.gender,
        'angkatan': dampingan.angkatan,
        'kampus': dampingan.kampus,
        'mediakontak': dampingan.mediakontak,
        'kontak': dampingan.kontak,
        'katakunci': dampingan.katakunci,
        'katakunci2':dampingan.katakunci2,
        'sesi': dampingan.sesi,
        'psname': dampingan.psname,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
/*      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String message = responseData["message"];
      Get.snackbar('Tambahkan Permintaan Dampingan', message,
        backgroundColor: Colors.green,
        colorText: Colors.white,);*/
    } else if (response.statusCode == 500) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String message = responseData["message"];
      Get.snackbar('Tambahkan Permintaan Dampingan', message,
        backgroundColor: Colors.red,
        colorText: Colors.white,);
    } else {
      Get.snackbar('Tambahkan Permintaan Dampingan', "Failed to create Dampingan",
        backgroundColor: Colors.red,
        colorText: Colors.white,);
    }
  }

  Future<void> deleteDampingan({required int reqid}) async {
    final response = await http.delete(
      Uri.parse('$serverUrl/deleteDampingan'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String message = responseData["message"];
      Get.snackbar('Hapus Dampingan', message,
        backgroundColor: Colors.green,
        colorText: Colors.white,);
    } else if (response.statusCode == 500) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String message = responseData["message"];
      Get.snackbar('Hapus Dampingan', message,
        backgroundColor: Colors.red,
        colorText: Colors.white,);
    } else {
      Get.snackbar('Hapus Dampingan', "Failed to delete Dampingan",
        backgroundColor: Colors.red,
        colorText: Colors.white,);
    }
  }
}

const String serverUrl = 'http://localhost:3000/dampingan';

Future<List<Dampingan>> fetchDampingan(int? psnim) async {
  final PSUsers? loggedInUser = await PSUsersDataManager.loadPSUsersData();

  if (loggedInUser != null) {
      // print(loggedInUser.psnim);
      psnim = loggedInUser.psnim;
      //print('async fetchDampingan: $psnim');
  } else {
    psnim = psnim;
  }

  final response = await http.get(Uri.parse('$serverUrl/getDampingan/$psnim'));

  //print('$serverUrl/getDampingan/$psnim');
  //print(response.statusCode);
  if (psnim == 0) {
    throw Exception('Tidak ada dampingan yang ditangani');
  }

  else if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<dynamic> requests = jsonResponse['dampingan'];
    return requests.map((data) => Dampingan.fromJson(data)).toList();
  } 
  else if (response.statusCode == 404) {
    throw Exception('Tidak ada dampingan yang ditangani');
  }
  else {
    throw Exception('Failed to load data');
  }
}

Future<List<Dampingan>> fetchDampinganList(int? psnim) async {
  final response = await http.get(Uri.parse('$serverUrl/getDampingan/$psnim'));
  if (psnim == 0) {
    throw Exception('Tidak ada dampingan yang ditangani');
  }

  else if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<dynamic> requests = jsonResponse['dampingan'];
    return requests.map((data) => Dampingan.fromJson(data)).toList();
  } 
  else if (response.statusCode == 404) {
    throw Exception('Tidak ada dampingan yang ditangani');
  }
  else {
    throw Exception('Failed to load data');
  }
}