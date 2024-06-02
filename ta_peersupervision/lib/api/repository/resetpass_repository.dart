// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ta_peersupervision/api/logic/resetpass_logic.dart';

class ResetPassRepository {
  final String serverUrl = 'http://localhost:3000/users';

// VERIFIKASI
  Future<bool> verifyOldBKPassword({required String bkusername, required String oldPassword}) async {
    final response = await http.post(
      Uri.parse('$serverUrl/verifyOldBKPassword'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'bkusername': bkusername, 'oldPassword': oldPassword}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData['isMatch'];
    } else {
      return false;
    }
  }

  Future<bool> verifyOldPSPassword({required int psnim, required String oldPassword}) async {
    final response = await http.post(
      Uri.parse('$serverUrl/verifyOldPSPassword'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'psnim': psnim, 'oldPassword': oldPassword}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData['isMatch'];
    } else {
      return false;
    }
  }

// Dilakukan oleh BK ITB
  Future<void> resetPassBK({required ResetPassBK resetpassbk}) async {
    final response = await http.put(Uri.parse('$serverUrl/resetPassBK'), headers:{
      'Content-Type': 'application/json',
    },
      body: jsonEncode({
        'bkusername' : resetpassbk.bkusername,
        'bkpasswordhash' : resetpassbk.bkpasswordhash,
      }),
    );

    if (response.statusCode == 200) {
//      final Map<String, dynamic> responseData = jsonDecode(response.body);
//      final String message = responseData["message"];
//      Get.snackbar('Register PS User', message);
    }
    else if (response.statusCode == 500) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String message = responseData["message"];
      Get.snackbar("Reset BK User's Password", message,
        backgroundColor: Colors.red,
        colorText: Colors.white,);
    }
    else {
      Get.snackbar("Reset BK User's Password", "Failed to reset BK User's Password",
        backgroundColor: Colors.red,
        colorText: Colors.white,);
      Get.toNamed('/bk-ubah-password');
    }
  }


// Dilakukan oleh PS ITB
  Future<void> resetPassPS({required ResetPassPS resetpassps}) async {
    final response = await http.put(Uri.parse('$serverUrl/resetPassPS'), headers:{
      'Content-Type': 'application/json',
    },
      body: jsonEncode({
        'psnim' : resetpassps.psnim,
        'pspasswordhash' : resetpassps.pspasswordhash,
      }),
    );

    if (response.statusCode == 200) {
//      final Map<String, dynamic> responseData = jsonDecode(response.body);
//      final String message = responseData["message"];
//      Get.snackbar('Register PS User', message);
    }
    else if (response.statusCode == 500) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String message = responseData["message"];
      Get.snackbar("Reset PS User's Password", message,
        backgroundColor: Colors.red,
        colorText: Colors.white,);
    }
    else {
      Get.snackbar("Reset PS User's Password", "Failed to reset PS User's Password",
        backgroundColor: Colors.red,
        colorText: Colors.white,);
      Get.toNamed('/ps-ubah-password');
    }
  }
}