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
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              child: const Text('Keluar'),
            ),
            const SizedBox(width: 10,),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }