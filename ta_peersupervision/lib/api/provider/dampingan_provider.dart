import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DampinganProvider with ChangeNotifier {
  final String serverUrl = 'https://ta-peersupervision-server.vercel.app/dampingan';

  List<dynamic> _dampinganList = [];

  List<dynamic> get dampinganList => _dampinganList;

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
    final response = await http.get(Uri.parse('https://ta-peersupervision-server.vercel.app/dampingan/countPendampingan/$reqid/'));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result['hasMeeting'];
    } else {
      throw Exception('Failed to check pertemuan');
    }
  }
}