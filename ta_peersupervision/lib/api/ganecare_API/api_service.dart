import 'dart:convert';
import 'package:http/http.dart' as http;

class GanecareService {
  static const String baseUrl = 'http://localhost:5000/ganecare';

  Future<List<dynamic>> fetchRooms() async {
    final response = await http.get(Uri.parse('$baseUrl/rooms'));
    return jsonDecode(response.body);
  }

  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    return jsonDecode(response.body);
  }

  Future<List<dynamic>> fetchGenderRoleComparison() async {
    final response = await http.get(Uri.parse('$baseUrl/gender-role-comparison'));
    return jsonDecode(response.body);
  }

  Future<List<dynamic>> fetchRoleComparison() async {
    final response = await http.get(Uri.parse('$baseUrl/role-comparison'));
    return jsonDecode(response.body);
  }

  Future<List<dynamic>> fetchInaIdRanking() async {
    final response = await http.get(Uri.parse('$baseUrl/ina-id-ranking'));
    return jsonDecode(response.body);
  }
}
