import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/api/logic/psusers_logic.dart';
import 'package:ta_peersupervision/api/logic/resetpass_logic.dart';
import 'package:ta_peersupervision/api/repository/resetpass_repository.dart';
import 'package:ta_peersupervision/api/shared_preferences/psusers_data_manager.dart';
import 'package:ta_peersupervision/widgets/custom_text_field.dart';

class UbahPSPassword extends StatefulWidget {
  const UbahPSPassword({super.key});

  @override
  State<UbahPSPassword> createState() => _UbahPSPasswordState();
}

class _UbahPSPasswordState extends State<UbahPSPassword> {
  final psoldpasswordhashController = TextEditingController();
  final pspasswordhashController = TextEditingController();

  ResetPassRepository repository = ResetPassRepository();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ubah Password Saya'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            controller: psoldpasswordhashController,
            hintText: 'Password Lama',
            obscureText: true,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            controller: pspasswordhashController,
            hintText: 'Password Baru',
            obscureText: true,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            PSUsers? psUser = await PSUsersDataManager.loadPSUsersData();

            if (psUser != null) {
              repository
                  .verifyOldPSPassword(
                      psnim: psUser.psnim,
                      oldPassword: psoldpasswordhashController.text)
                  .then((isValid) {
                if (!isValid) {
                  Get.snackbar(
                    'Ubah Kata Sandi',
                    'Kata sandi lama tidak cocok',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  ); // Warna teks snackbar
                } else {
                  ResetPassPS resetpassps = ResetPassPS(
                    psnim: psUser.psnim,
                    pspasswordhash: pspasswordhashController.text,
                  );

                  repository.resetPassPS(resetpassps: resetpassps).then((value) {
                    Navigator.of(context).pop();
                    Get.snackbar(
                      'Ubah Kata Sandi Anggota PS ITB',
                      'Kata sandi berhasil diubah',
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
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
          child: const Text('Batal'),
        ),
      ],
    );
  }
}
