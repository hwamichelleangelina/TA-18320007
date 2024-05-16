import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/api/logic/bkusers_logic.dart';
import 'package:ta_peersupervision/api/logic/resetpass_logic.dart';
import 'package:ta_peersupervision/api/repository/resetpass_repository.dart';
import 'package:ta_peersupervision/api/shared_preferences/bkusers_data_manager.dart';

class UbahBKPassword extends StatefulWidget {
  const UbahBKPassword({super.key});

  @override
  State<UbahBKPassword> createState() => _UbahBKPasswordState();
}

class _UbahBKPasswordState extends State<UbahBKPassword> {
  final bkoldpasswordhashController = TextEditingController();
  final bkpasswordhashController = TextEditingController();

  ResetPassRepository repository = ResetPassRepository();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ubah Password Saya'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: bkoldpasswordhashController,
            decoration: const InputDecoration(labelText: 'Password Lama'),
            obscureText: true,
          ),

          const SizedBox(height: 10),

          TextField(
            controller: bkpasswordhashController,
            decoration: const InputDecoration(labelText: 'Password Baru'),
            obscureText: true,
          ),
        ],
      ),

      actions: [
        ElevatedButton(
          onPressed: () async {
            BKUsers? bkUser = await BKUsersDataManager.loadBKUsersData();

            if (bkUser != null) {
              repository.verifyOldBKPassword(bkusername: bkUser.bkusername, oldPassword: bkoldpasswordhashController.text).then((isValid) {
                if (!isValid) {
                  Get.snackbar('Ubah Kata Sandi', 'Kata sandi lama tidak cocok',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,); // Warna teks snackbar
                } else {
                  ResetPassBK resetpassbk = ResetPassBK(
                    bkusername: bkUser.bkusername,
                    bkpasswordhash: bkpasswordhashController.text,
                  );

                  repository.resetPassBK(resetpassbk: resetpassbk).then((value) {
                    Navigator.of(context).pop();
                    Get.snackbar('Ubah Kata Sandi Bimbingan Konseling ITB', 'Kata sandi berhasil diubah',
                      backgroundColor: Colors.green,
                      colorText: Colors.white,); 
                  }); 
                }
              });
            }
          },
          child: const Text('Simpan'),
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
  }
}
