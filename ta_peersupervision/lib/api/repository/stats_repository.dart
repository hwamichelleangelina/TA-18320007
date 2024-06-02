// api_service.dart
// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ta_peersupervision/api/logic/stats_logic.dart';

class StatsRepository {
  final String baseUrl = 'http://localhost:3000/stats';

  Future<List<SessionPerMonth>> getSessionsPerMonth() async {
    final response = await http.get(Uri.parse('$baseUrl/jadwalpermonth'));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((json) => SessionPerMonth.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load sessions per month');
    }
  }

  Future<List<TopPSDampingan>> getTopPSDampingan() async {
    final response = await http.get(Uri.parse('$baseUrl/topPSdampingan'));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((json) => TopPSDampingan.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load top PS clients');
    }
  }

  Future<List<TopPSJadwal>> getTopPSJadwal() async {
    final response = await http.get(Uri.parse('$baseUrl/topPSpendampingan'));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((json) => TopPSJadwal.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load top PS sessions');
    }
  }

Future<Map<String, List<ClientDistribution>>> getClientDistribution() async {
  final response = await http.get(Uri.parse('$baseUrl/distribution'));
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    //print(jsonResponse);
    return jsonResponse.map((key, value) => MapEntry(
        key,
        (value as List)
            .map((item) => ClientDistribution.fromJson(item))
            .toList()));
  } else {
    throw Exception('Failed to load client distribution');
  }
}



  Future<List<Topic>> getTopTopics() async {
    final response = await http.get(Uri.parse('$baseUrl/topTopics'));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((json) => Topic.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load top topics pendampingan');
    }
  }

Future<List<Recommendation>> getRecommendationRatio() async {
  final response = await http.get(Uri.parse('$baseUrl/recRatio'));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    //print(jsonResponse);
    return jsonResponse
        .map((item) => Recommendation.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to load recommendation ratio');
  }
}

}