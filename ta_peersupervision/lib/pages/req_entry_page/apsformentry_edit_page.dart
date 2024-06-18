// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ta_peersupervision/api/logic/dampingan_logic.dart';
import 'package:ta_peersupervision/api/logic/psusers_logic.dart';
import 'package:ta_peersupervision/api/provider/dampingan_provider.dart';
import 'package:ta_peersupervision/api/repository/dampingan_repository.dart';
import 'package:ta_peersupervision/api/repository/psusers_repository.dart';
import 'package:ta_peersupervision/api/repository/rujukan_repository.dart.dart';
import 'package:ta_peersupervision/widgets/footer.dart';

class DampinganFormPage extends StatefulWidget {
  const DampinganFormPage({super.key});

  @override
  _DampinganFormPageState createState() => _DampinganFormPageState();
}

class _DampinganFormPageState extends State<DampinganFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _initialController = TextEditingController();
  final TextEditingController _angkatanController = TextEditingController();
  final TextEditingController _kontakController = TextEditingController();

  String? gender;
  String? fakultas;
  String? kampus;
  String? tingkat;
  String? mediakontak;
  String? katakunci;
  String? katakunci2;
  String? sesi;
  String? psname;

  PSUsersRepository repository = PSUsersRepository();
  DampinganRepository dampinganRepo = DampinganRepository();
  RujukanRepository rujukan = RujukanRepository();

  @override
  void dispose() {
    _initialController.dispose();
    _angkatanController.dispose();
    _kontakController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DampinganProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  textAlign: TextAlign.center,
                  'Informasi Permintaan Pendampingan',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _initialController,
                decoration: const InputDecoration(
                  labelText: 'Inisial Dampingan',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inisial dampingan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                items: ['Laki-laki', 'Perempuan'].map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
                value: gender,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Fakultas',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                items: [
                  'STEI', 'SBM', 'FTTM', 'SITH', 'FTSL', 'FMIPA', 'SF', 'FSRD', 'FTMD', 'FTI', 'FITB', 'SAPPK', 'Lain-lain'
                ].map((String fakultas) {
                  return DropdownMenuItem<String>(
                    value: fakultas,
                    child: Text(fakultas),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    fakultas = value;
                  });
                },
                value: fakultas,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Kampus',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                items: ['ITB Ganesha', 'ITB Cirebon', 'ITB Jatinangor'].map((String kampus) {
                  return DropdownMenuItem<String>(
                    value: kampus,
                    child: Text(kampus),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    kampus = value;
                  });
                },
                value: kampus,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _angkatanController,
                decoration: const InputDecoration(
                  labelText: 'Angkatan',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null) {
                    if (int.tryParse(value) == null) {
                      return 'Angkatan harus berupa angka';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Tingkat',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                items: ['Sarjana', 'Pascasarjana'].map((String tingkat) {
                  return DropdownMenuItem<String>(
                    value: tingkat,
                    child: Text(tingkat),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    tingkat = value;
                  });
                },
                value: tingkat,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Media Kontak',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                items: ['WA', 'Email', 'Line'].map((String mediakontak) {
                  return DropdownMenuItem<String>(
                    value: mediakontak,
                    child: Text(mediakontak),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    mediakontak = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Media Kontak tidak boleh kosong';
                  }
                  return null;
                },
                value: mediakontak,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _kontakController,
                decoration: const InputDecoration(
                  labelText: 'Kontak Dampingan',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kontak dampingan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Kata Kunci',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                items: [
                  'Akademik', 'Finansial', 'Keluarga', 'Percintaan', 'Kehidupan Kampus', 'Kesehatan', 'Karir dan Masa Depan', 'Lain-lain'
                ].map((String katakunci) {
                  return DropdownMenuItem<String>(
                    value: katakunci,
                    child: Text(katakunci),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    katakunci = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kata Kunci tidak boleh kosong';
                  }
                  return null;
                },
                value: katakunci,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String?>(
                decoration: const InputDecoration(
                  labelText: 'Kata Kunci Tambahan',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                items: [
                  'Akademik', 'Finansial', 'Keluarga', 'Percintaan', 'Kehidupan Kampus', 'Kesehatan', 'Karir dan Masa Depan', 'Lain-lain'
                ].map((String? katakunci2) {
                  return DropdownMenuItem<String>(
                    value: katakunci2,
                    child: Text(katakunci2 ?? 'Pilih kata kunci tambahan'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    katakunci2 = value;
                  });
                },
                value: katakunci2,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Sesi',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                items: ['Online', 'Offline'].map((String sesi) {
                  return DropdownMenuItem<String>(
                    value: sesi,
                    child: Text(sesi),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    sesi = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Sesi tidak boleh kosong';
                  }
                  return null;
                },
                value: sesi,
              ),
              const SizedBox(height: 16),
              FutureBuilder<List<ActiveUser>>(
                future: repository.fetchPSNames(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Error loading Pendamping Sebaya names');
                  } else {
                    return DropdownButtonFormField<ActiveUser>(
                      decoration: const InputDecoration(
                        labelText: 'Pendamping Sebaya',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                      value: psname != null ? snapshot.data!.firstWhere((user) => user.psname == psname) : null,
                      items: snapshot.data!.map((user) {
                        return DropdownMenuItem<ActiveUser>(
                          value: user,
                          child: Text(user.psname),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          psname = value!.psname;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Pilih pendamping sebaya';
                        }
                        return null;
                      },
                    );
                  }
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Dampingan dampingan = Dampingan(
                      initial: _initialController.text,
                      fakultas: fakultas,
                      gender: gender,
                      kampus: kampus,
                      angkatan: int.tryParse(_angkatanController.text),
                      mediakontak: mediakontak!,
                      kontak: _kontakController.text,
                      sesi: sesi!,
                      psname: psname,
                      katakunci: katakunci!,
                      katakunci2: katakunci2,
                      tingkat: tingkat!
                    );

                    dampinganRepo.importDampingan(dampingan: dampingan).then((value) async {
                      Get.toNamed('/aps-requests');
                      await provider.fetchDampingan();
                    });
                    Get.snackbar('Tambah Permintaan Pendampingan Baru', 'Data Dampingan ${_initialController.text} berhasil disimpan',
                        backgroundColor: Colors.green, colorText: Colors.white);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 19.0, horizontal: 32.0),
                  textStyle: const TextStyle(fontSize: 15.0, fontFamily: 'Montserrat'),
                ),
                child: const Text('Simpan'),
              ),
              const SizedBox(height: 30,),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
