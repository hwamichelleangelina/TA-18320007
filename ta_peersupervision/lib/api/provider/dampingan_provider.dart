// ignore_for_file: avoid_print, use_rethrow_when_possible

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ta_peersupervision/api/logic/psusers_logic.dart';
import 'package:ta_peersupervision/api/repository/psusers_repository.dart';

class DampinganProvider with ChangeNotifier {
  final String serverUrl = 'http://localhost:3000/dampingan';

  List<dynamic> _dampinganList = [];
  List<dynamic> _noPSdampinganList = [];
  final PSUsersRepository _psUsersRepository = PSUsersRepository();

  List<dynamic> get dampinganList => _dampinganList;
  List<dynamic> get noPSdampinganList => _noPSdampinganList;

  DampinganProvider() {
    fetchDampingan();
  }

  Future<void> fetchDampingan() async {
    final response = await http.get(
      Uri.parse('$serverUrl/getDampingan'),
    );

    if (response.statusCode == 200) {
      _dampinganList = json.decode(response.body);
      notifyListeners();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchNoPSDampingan() async {
    final response = await http.get(
      Uri.parse('$serverUrl/getNoPSDampingan'),
    );

    if (response.statusCode == 200) {
      _noPSdampinganList = json.decode(response.body);
      notifyListeners();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> deleteDampingan(int reqid) async {
    final response = await http.delete(
      Uri.parse('$serverUrl/deleteDampingan/$reqid'),
    );

    if (response.statusCode == 200) {
      _dampinganList.removeWhere((item) => item['reqid'] == reqid);
      notifyListeners();
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

  Future<bool> checkPertemuan(int reqid) async {
    final response = await http.get(Uri.parse('http://localhost:3000/dampingan/countPendampingan/$reqid/'));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result['hasMeeting'];
    } else {
      throw Exception('Failed to check pertemuan');
    }
  }

  Future<void> updateDampingan(int reqid, Map<String, dynamic> newData) async {
    final url = 'http://localhost:3000/dampingan/updateDampingan/$reqid';
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(newData),
      );
      if (response.statusCode == 200) {
        // Handle success response
        print('Data updated successfully');
        notifyListeners();
      } else {
        // Handle error response
        print('Failed to update data');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<List<ActiveUser>> fetchPSNames() async {
    return await _psUsersRepository.fetchPSNames();
  }
}