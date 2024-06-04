// api_service.dart
// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ta_peersupervision/api/logic/stats_logic.dart';

class StatsRepository {
  final String baseUrl = 'http://localhost:3000/stats';

  Future<List<SessionPerMonth>> getSessionsPerMonth(year) async {
    final response = await http.get(Uri.parse('$baseUrl/jadwalpermonth/$year'));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((json) => SessionPerMonth.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load sessions per month');
    }
  }

  Future<List<PotentialRujuk>> getPotentialRujuk(year) async {
    final response = await http.get(Uri.parse('$baseUrl/potentially/$year'));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((json) => PotentialRujuk.fromJson(json)).where((row) => row.count > 5).toList();
    } else {
      throw Exception('Failed to load potentially rujukan');
    }
  }

  Future<List<PotentialRujuk>> getPotentialRujukAllTime() async {
    final response = await http.get(Uri.parse('$baseUrl/potentially'));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((json) => PotentialRujuk.fromJson(json)).where((row) => row.count > 5).toList();
    } else {
      throw Exception('Failed to load potentially rujukan');
    }
  }

  Future<List<TopPSDampingan>> getTopPSDampingan(year) async {
    final response = await http.get(Uri.parse('$baseUrl/topPSdampingan/$year'));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((json) => TopPSDampingan.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load top PS clients');
    }
  }

  Future<List<TopPSJadwal>> getTopPSJadwal(year) async {
    final response = await http.get(Uri.parse('$baseUrl/topPSpendampingan/$year'));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((json) => TopPSJadwal.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load top PS sessions');
    }
  }

Future<Map<String, List<ClientDistribution>>> getClientDistribution(year) async {
  final response = await http.get(Uri.parse('$baseUrl/distribution/$year'));
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



  Future<List<Topic>> getTopTopics(year) async {
    final response = await http.get(Uri.parse('$baseUrl/topTopics/$year'));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((json) => Topic.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load top topics pendampingan');
    }
  }

Future<List<Recommendation>> getRecommendationRatio(year) async {
  final response = await http.get(Uri.parse('$baseUrl/recRatio/$year'));
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

  Future<List<SessionPerMonth>> getSessionsPerMonthAllTime() async {
    final response = await http.get(Uri.parse('$baseUrl/jadwalpermonth'));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((json) => SessionPerMonth.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load sessions per month');
    }
  }

  Future<List<TopPSDampingan>> getTopPSDampinganAllTime() async {
    final response = await http.get(Uri.parse('$baseUrl/topPSdampingan'));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((json) => TopPSDampingan.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load top PS clients');
    }
  }

  Future<List<TopPSJadwal>> getTopPSJadwalAllTime() async {
    final response = await http.get(Uri.parse('$baseUrl/topPSpendampingan'));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((json) => TopPSJadwal.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load top PS sessions');
    }
  }

Future<Map<String, List<ClientDistribution>>> getClientDistributionAllTime() async {
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



  Future<List<Topic>> getTopTopicsAllTime() async {
    final response = await http.get(Uri.parse('$baseUrl/topTopics'));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((json) => Topic.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load top topics pendampingan');
    }
  }

Future<List<Recommendation>> getRecommendationRatioAllTime() async {
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