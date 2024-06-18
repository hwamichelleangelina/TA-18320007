// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ta_peersupervision/api/logic/rujukan_logic.dart';

class RujukanRepository {
  final String serverUrl = 'http://localhost:3000/rujukan';

  Future<void> createRujukan({required int reqid}) async {
    final response = await http.post(
      Uri.parse('$serverUrl/createRujukan/$reqid'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
    } else if (response.statusCode == 500) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String message = responseData["message"];
      print(message);
    } else {
      print('failed');
    }
  }

  Future<List<Rujukan>> fetchRujukan() async {
    final response = await http.get(Uri.parse('$serverUrl/getRujukan'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((results) => Rujukan.fromJson(results)).toList();
    } else {
      throw Exception('Failed to load dampingan rujukan');
    }
  }

  Future<void> updateRujukan({required int? reqid, required int isRujukanNeed}) async {
    final response = await http.put(
      Uri.parse('$serverUrl/updateRujukan/$reqid'), 
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({'isRujukanNeed': isRujukanNeed}),
    );

    if (response.statusCode == 200) {
      print('Update successful');
    } else if (response.statusCode == 500) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String message = responseData["message"];
      print('Server error: $message');
    } else {
      print('Failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }
}