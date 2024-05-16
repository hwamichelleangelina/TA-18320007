import 'dart:convert';

import 'package:ta_peersupervision/api/logic/bkusers_logic.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BKUsersDataManager {
  static Future<BKUsers?> loadBKUsersData() async {
    final prefs = await SharedPreferences.getInstance();

    final bkusersJson = prefs.getString('bkusersJson');

    if (bkusersJson != null) {
      final Map<String, dynamic> bkusersMap = json.decode(bkusersJson);
      final BKUsers bkusers = BKUsers.fromJson(bkusersMap);

      return bkusers;
    }
    else {
      return null;
    }
  }

  static Future<void> saveBKUsersData(BKUsers bkusersJson) async {
    final prefs = await SharedPreferences.getInstance(); 
    String bkusers = json.encode(bkusersJson.toJson());

    await prefs.setString('bkusersJson', bkusers);
  }

  static Future<bool> hasBKUsersData() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.containsKey('bkusersJson'); 
  }

  static Future<void> removeBKUSersData() async {
    final prefs = await SharedPreferences.getInstance(); 

    await prefs.remove('bkusersJson');
  }
}