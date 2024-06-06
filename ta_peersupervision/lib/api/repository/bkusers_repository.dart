// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ta_peersupervision/api/logic/bkusers_logic.dart';
import 'package:ta_peersupervision/api/shared_preferences/bkusers_data_manager.dart';

class BKUsersRepository {
  final String serverUrl = 'https://ta-peersupervision-server.vercel.app/bkusers';

  Future<void> registerBKUsers({required BKUsers bkusers}) async {
    final response = await http.post(Uri.parse('$serverUrl/registerBKUsers'), headers:{
      'Content-Type': 'application/json',
    },
      body: jsonEncode({
        'bkname' : bkusers.bkname,
        'bknpm' : bkusers.bknpm,
        'bkusername' : bkusers.bkusername,
        'bkpasswordhash' : bkusers.bkpasswordhash,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String message = responseData["message"];
      Get.snackbar('Register BK User', message,
        backgroundColor: Colors.green,
        colorText: Colors.white,);
    }
    else if (response.statusCode == 500) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String message = responseData["message"];
      Get.snackbar('Register BK User', message,
        backgroundColor: Colors.red,
        colorText: Colors.white,);
    }
    else {
      Get.snackbar('Register BK User', "Failed to register BK User",
        backgroundColor: Colors.red,
        colorText: Colors.white,);
      Get.toNamed('/bk-register');
    }
  }

  Future<BKUsers?> loginBKUsers({required String bkusername, required String bkpasswordhash}) async {
    final response = await http.post(
      Uri.parse('$serverUrl/loginBKUsers'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'bkusername': bkusername,
        'bkpasswordhash': bkpasswordhash,
      }),
    ); 

//    print(response.statusCode);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final bkusers = BKUsers.fromJson(responseData['bkusers']);
      
      await BKUsersDataManager.saveBKUsersData(bkusers);

//      print(bkusers);
      return bkusers;
    }
    else if (response.statusCode == 401) {
//      print("debug");
      return null;
    }
    else {
      Get.toNamed('/bk-login');
      Get.snackbar('Login Failed', "Error while logging in BK User",
        backgroundColor: Colors.red,
        colorText: Colors.white,);
//      print(bkusername);
//      print(bkpasswordhash);
      throw Exception('Error while logging in BK User. Failed to login');
    }
  }

  Future<BKUsers?> logoutBKUsers() async {
    await BKUsersDataManager.removeBKUSersData();
    Get.toNamed('/bk-login');
    
    return null;
  }

/*  Future<List<BKUsers>> getUsers({required int bknpm}) async {
    final response = await http.get(Uri.parse('$serverUrl/$idnim'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((users) => Users.fromJson(users)).toList();
    }
    else {
      throw Exception("Failed to load user's information");
    }
  }
*/

/*  Future<void> updateUsers({required int idusers, required Users users}) async {
    final response = await http.put(Uri.parse('$serverUrl/$idusers'), headers:{
      'Content-Type': 'application/json',
    },
      body: jsonEncode(users),
    );
    if (response.statusCode == 200) {
      Get.snackbar('User Update', 'User has been updated successfully.');
    }
    else {
      Get.snackbar('User Update', 'Failed to update user information.');
    }
  }
*/
/*  Future<void> deleteUsers({required int idusers}) async {
    final response = await http.delete(Uri.parse('$serverUrl/$idusers'));

    if (response.statusCode == 200) {
      Get.snackbar('User Delete', 'User deleted successfully.');
    }
    else {
      Get.snackbar('User Delete', 'Failed to update user information.');
    }    
  }
*/
}