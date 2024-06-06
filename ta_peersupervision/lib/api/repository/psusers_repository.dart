// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ta_peersupervision/api/logic/psusers_logic.dart';
import 'package:ta_peersupervision/api/shared_preferences/psusers_data_manager.dart';

class PSUsersRepository {
  final String serverUrl = 'https://ta-peersupervision-server.vercel.app/psusers';

// Dilakukan oleh BK ITB
  Future<void> registerPSUsers({required PSUsers psusers}) async {
    final response = await http.post(Uri.parse('$serverUrl/registerPSUsers'), headers:{
      'Content-Type': 'application/json',
    },
      body: jsonEncode({
        'psname' : psusers.psname,
        'psnim' : psusers.psnim,
        'pspasswordhash' : psusers.pspasswordhash,
        'psisActive' : psusers.psisActive,
        'psisAdmin' : psusers.psisAdmin
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
      Get.snackbar('Register PS User', message,
        backgroundColor: Colors.red,
        colorText: Colors.white,);
    }
    else {
      Get.snackbar('Register PS User', "Failed to register PS User",
        backgroundColor: Colors.red,
        colorText: Colors.white,);
      Get.toNamed('/bk-tambah-anggota');
    }
  }

  Future<PSUsers?> loginPSUsers({required int psnim, required String pspasswordhash}) async {
    try {
      final response = await http.post(
        Uri.parse('$serverUrl/loginPSUsers'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'psnim': psnim,
          'pspasswordhash': pspasswordhash,
        }),
      );

      // Logging status code and response body
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final psusers = PSUsers.fromJson(responseData['psusers']);

        await PSUsersDataManager.savePSUsersData(psusers);

        return psusers;
      } else if (response.statusCode == 401) {
        print('Invalid credentials.');
        return null;
      } else if (response.statusCode == 403) {
        Get.snackbar('Login Failed', 'User is inactive.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return null;
      } else {
        Get.toNamed('/ps-login');
        Get.snackbar('Login Failed', "Error while logging in PS User",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        throw Exception('Error while logging in PS User. Failed to login');
      }
    } catch (e) {
      print('An error occurred: $e');
      Get.snackbar('Login Failed', "An unexpected error occurred.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    }
  }

  Future<void> updatePSUsers({required PSUsers psusers}) async {
    final response = await http.put(Uri.parse('$serverUrl/updatePSUsers'), headers:{
      'Content-Type': 'application/json',
    },
      body: jsonEncode({
        'psname' : psusers.psname,
        'psnim' : psusers.psnim,
        'pspasswordhash' : psusers.pspasswordhash,
        'psisActive' : psusers.psisActive,
        'psisAdmin' : psusers.psisAdmin
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
      Get.snackbar('Update PS User', message,
        backgroundColor: Colors.red,
        colorText: Colors.white,);
    }
    else {
      Get.snackbar('Update PS User', "Failed to update PS User",
        backgroundColor: Colors.red,
        colorText: Colors.white,);
      Get.toNamed('/bk-tambah-anggota');
    }
  }

  Future<PSUsers?> logoutPSUsers() async {
    await PSUsersDataManager.removePSUSersData();
    Get.toNamed('/ps-login');
    
    return null;
  }

  Future<void> nonActivate({required NonActivate nonactivate}) async {
    final response = await http.put(Uri.parse('$serverUrl/nonActivateUsers'), headers:{
      'Content-Type': 'application/json',
    },
      body: jsonEncode({
        'psnim' : nonactivate.psnim,
      }),
    );

    if (response.statusCode == 200) {
    }
    else if (response.statusCode == 500) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String message = responseData["message"];
      Get.snackbar("Non Activate PS User", message,
        backgroundColor: Colors.red,
        colorText: Colors.white,);
    }
    else {
      Get.snackbar("Non Activate PS User", "Failed to non activate PS User",
        backgroundColor: Colors.red,
        colorText: Colors.white,);
      Get.toNamed('/bk-anggota-ps');
    }
  }

  Future<List<FreqPS>> fetchFreqPS() async {
    try {
      print('Fetching frequency of PS users...');
      final response = await http.get(Uri.parse('$serverUrl/countPSDone'));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((user) => FreqPS.fromJson(user)).toList();
      } else {
        throw Exception('Failed to load PS users pendampingan frequencies');
      }
    } catch (e) {
      print('An error occurred: $e');
      throw Exception('An unexpected error occurred.');
    }
  }

  Future<List<FreqDampingan>> fetchCountDampingan() async {
    final response = await http.get(Uri.parse('$serverUrl/countPSDampinganDone'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((user) => FreqDampingan.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load PS users dampingan handled');
    }
  }

  Future<List<PSUser>> fetchUsers() async {
    final response = await http.get(Uri.parse('$serverUrl/getAllPSUsers'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((user) => PSUser.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load PS users');
    }
  }

  Future<List<NonActiveUser>> fetchNAUsers() async {
    final response = await http.get(Uri.parse('$serverUrl/getNAUsers'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((user) => NonActiveUser.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load Non Active PS users');
    }
  }

  Future<List<ActiveUser>> fetchPSNames() async {
    final response = await http.get(Uri.parse('$serverUrl/getActivePS'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((user) => ActiveUser.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load Active PS users');
    }
  }
}