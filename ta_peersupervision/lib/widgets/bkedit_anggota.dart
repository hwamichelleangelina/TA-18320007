import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/api/logic/psusers_logic.dart';
import 'package:ta_peersupervision/api/repository/psusers_repository.dart';

class EditAnggota extends StatefulWidget {
  final Function(String, String, String, bool, bool) onSubmit;

  const EditAnggota({super.key, required this.onSubmit});

  @override
  // ignore: library_private_types_in_public_api
  _EditAnggotaState createState() => _EditAnggotaState();
}

class _EditAnggotaState extends State<EditAnggota> {
  String psname = '';
  String psnim = '';
  String pspasswordhash = '';
  bool psisActive = false;
  bool psisAdmin = false;

  PSUsersRepository repository = PSUsersRepository();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Nama',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              width: 400.0,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    psname = value;
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
              width: 400.0,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    psnim = value;
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
              width: 400.0,
              child: TextField(
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    pspasswordhash = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20.0),

            const Text(
              'Status Anggota',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Aktif'),
                Checkbox(
                  value: psisActive,
                  onChanged: (value) {
                    setState(() {
                      psisActive = value!;
                    });
                  },
                ),
                const Text('Tidak Aktif'),
                Checkbox(
                  value: !psisActive,
                  onChanged: (value) {
                    setState(() {
                      psisActive = !value!;
                    });
                  },
                ),
              ]
            ),

            const SizedBox(height: 20.0),
            const Text(
              'Kepala Divisi Kuratif',
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
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                if (psname.isEmpty || psnim.isEmpty || pspasswordhash.isEmpty) {
                  Get.snackbar('Perbarui Data PS ITB', 'Semua kolom harus terisi!',
                    backgroundColor: Colors.red,
                    colorText: Colors.white);
                }
                else {
                  widget.onSubmit(psname, psnim, pspasswordhash, psisActive, psisAdmin);
                  int psActive = 0;
                  if (psisActive == true) {
                    psActive = 1;
                  }

                  int psAdmin = 0;
                  if (psisAdmin == true) {
                    psAdmin = 1;
                  }

                  PSUsers psusers = PSUsers(
                    psname: psname,
                    psnim: int.tryParse(psnim) ?? 0,
                    pspasswordhash: pspasswordhash,
                    psisActive: psActive,
                    psisAdmin: psAdmin
                  );

                  repository.updatePSUsers(psusers: psusers).then((value) {
                    Navigator.of(context).pop();
                  }); 
                  Get.snackbar('Perbarui Data Anggota PS ITB', 'Data Pendamping Sebaya berhasil diperbarui',
                    backgroundColor: Colors.green, colorText: Colors.white);           
                } 
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 19.0, horizontal: 32.0),
                textStyle: const TextStyle(fontSize: 15.0, fontFamily: 'Montserrat'),
              ),
              child: const Text('Perbarui'),
            ),
          ],
        ),
      ),
    );
  }
/*
  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: const Color.fromARGB(255, 123, 217, 126), // Mengatur warna hijau
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
*/
}