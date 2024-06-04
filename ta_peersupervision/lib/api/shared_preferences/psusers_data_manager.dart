import 'dart:convert';

import 'package:ta_peersupervision/api/logic/psusers_logic.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PSUsersDataManager {
  static Future<PSUsers?> loadPSUsersData() async {
    final prefs = await SharedPreferences.getInstance();

    final psusersJson = prefs.getString('psusersJson');

    if (psusersJson != null) {
      final Map<String, dynamic> psusersMap = json.decode(psusersJson);
      final PSUsers psusers = PSUsers.fromJson(psusersMap);

      return psusers;
    }
    else {
      return null;
    }
  }

  static Future<void> savePSUsersData(PSUsers psusersJson) async {
    final prefs = await SharedPreferences.getInstance();
    String psusers = json.encode(psusersJson.toJson());

    await prefs.setString('psusersJson', psusers);
  }

  static Future<bool> hasPSUsersData() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.containsKey('psusersJson'); 
  }

  static Future<String?> getPSUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final psusersJson = prefs.getString('psusersJson');
    if (psusersJson != null) {
      final psusersData = jsonDecode(psusersJson);
      return psusersData['psname'];
    }
    return null;
  }

  static Future<void> removePSUSersData() async {
    final prefs = await SharedPreferences.getInstance(); 

    await prefs.remove('psusersJson');
  }
}