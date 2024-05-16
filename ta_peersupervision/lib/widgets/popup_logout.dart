import 'package:flutter/material.dart';
import 'package:ta_peersupervision/api/repository/bkusers_repository.dart';
import 'package:ta_peersupervision/api/repository/psusers_repository.dart';

void logoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Keluar Aplikasi'),
          content: const Text('Anda akan keluar dari aplikasi?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Implementasi logika keluar di sini
              PSUsersRepository repository = PSUsersRepository();
              BKUsersRepository bkrepo = BKUsersRepository();

              repository.logoutPSUsers();
              bkrepo.logoutBKUsers();
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