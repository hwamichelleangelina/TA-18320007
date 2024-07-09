// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/api/logic/psusers_logic.dart';
import 'package:ta_peersupervision/api/repository/psusers_repository.dart';
import 'package:ta_peersupervision/dummy/usedatanggota_database.dart';

class UpdatePSUserDialog extends StatefulWidget {
  final String name;
  final String nim;
  final Function(String, String, String, bool) onSubmit;

  const UpdatePSUserDialog({
    required this.name,
    required this.nim,
    required this.onSubmit,
    super.key,
  });

  @override
  _UpdatePSUserDialogState createState() => _UpdatePSUserDialogState();
}

class _UpdatePSUserDialogState extends State<UpdatePSUserDialog> {
  late String _name;
  late String _nim;
  late String _password;
  bool psisAdmin = false;

  PSUsersRepository repository = PSUsersRepository();

  @override
  void initState() {
    super.initState();
    _name = widget.name;
    _nim = widget.nim;
    _password = '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Perbarui Data'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Text(
              'Nama',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              width: 300.0,
              child: TextFormField(
                initialValue: _name,
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'NIM',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              width: 300.0,
              child: TextFormField(
                initialValue: _nim,
                onChanged: (value) {
                  setState(() {
                    _nim = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Set Ulang Password',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              width: 300.0,
              child: TextField(
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 30.0),
            const Text(
              'Admin (Ketua Divisi) Pendamping Sebaya ITB',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Posisikan sebagai Admin'),
                Checkbox(
                  value: psisAdmin,
                  onChanged: (value) {
                    setState(() {
                      psisAdmin = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () async {
                if (_name.isEmpty || _nim.isEmpty) {
                  Get.snackbar('Perbarui Data PS ITB', 'Semua kolom identitas harus terisi!',
                      backgroundColor: Colors.red,
                      colorText: Colors.white);
                } else {
                  widget.onSubmit(_name, _nim, _password, psisAdmin);
                  int psAdmin = 0;
                  if (psisAdmin == true) {
                    psAdmin = 1;
                  }

                  PSUsers psusers = PSUsers(
                      psname: _name,
                      psnim: int.tryParse(_nim) ?? 0,
                      pspasswordhash: _password,
                      psisActive: 1,
                      psisAdmin: psAdmin);

                  repository.updatePSUsers(psusers: psusers).then((value) {
                    Navigator.of(context).pop();
                  });

                  await _fetchActiveUsers();

                  Get.snackbar('Perbarui Data Anggota PS ITB', 'Data Pendamping Sebaya $_name berhasil diperbarui',
                      backgroundColor: Colors.green, colorText: Colors.white);
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 19.0, horizontal: 32.0),
                textStyle: const TextStyle(fontSize: 15.0, fontFamily: 'Montserrat'),
              ),
              child: const Text('Perbarui'),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              child: const Text('Batal'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchActiveUsers() async {
    try {
      // Mengambil data anggota aktif dari repository
      List<PSUser> activeUsers = await repository.fetchUsers();
      
      // Update tampilan jika perlu
      setState(() {
        // Mengisi data dari hasil pengambilan data
        dataDatabase = activeUsers.map((user) => {
          'role': user.role,
          'name': user.name,
          'nim': user.nim.toString(),
        }).toList();
      });
    } catch (error) {
      // Penanganan kesalahan jika diperlukan
      print('Error fetching active users: $error');
    }
  }
}