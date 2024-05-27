import 'package:flutter/material.dart';
import 'package:ta_peersupervision/api/logic/psusers_logic.dart';
import 'package:ta_peersupervision/api/repository/bkusers_repository.dart';
import 'package:ta_peersupervision/api/repository/psusers_repository.dart';
import 'package:ta_peersupervision/api/shared_preferences/psusers_data_manager.dart';

void logoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Keluar Aplikasi'),
          content: const Text('Anda akan keluar dari aplikasi?'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                // Implementasi logika keluar di sini
              PSUsersRepository repository = PSUsersRepository();
              BKUsersRepository bkrepo = BKUsersRepository();

              final PSUsers? loggedInUser = await PSUsersDataManager.loadPSUsersData();

              if (loggedInUser != null) {
                repository.logoutPSUsers();
              } else {
                bkrepo.logoutBKUsers();
              }
              },
              child: const Text('Keluar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 248, 146, 139)),
              ),
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }