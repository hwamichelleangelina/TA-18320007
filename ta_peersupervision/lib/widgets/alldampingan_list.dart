// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ta_peersupervision/api/logic/psusers_logic.dart';
import 'package:ta_peersupervision/api/provider/dampingan_provider.dart';
import 'package:ta_peersupervision/api/repository/psusers_repository.dart';
import 'package:ta_peersupervision/constants/colors.dart';

class AllDampinganList extends StatefulWidget {
  const AllDampinganList({super.key});

  @override
  _AllDampinganListState createState() => _AllDampinganListState();
}

class _AllDampinganListState extends State<AllDampinganList> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DampinganProvider>(context);

    final filteredList = provider.dampinganList.where((item) {
      return item['initial'].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Permintaan Pendampingan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Pencarian',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),

          const SizedBox(height: 20),

          Center(
            child: ElevatedButton(
              onPressed: () {
                // Aksi untuk tombol tambah
                Get.toNamed('/aps-dampingan-entry');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.green, // Warna hijau pada tombol
              ),
              child: const Text('Tambah Dampingan Baru', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
            ),
          ),

          const SizedBox(height: 16),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final item = filteredList[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CustomColor.purpleBg2,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: FutureBuilder<bool>(
                  future: provider.checkPertemuan(item['reqid']),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListTile(
                        title: Text(item['initial'], style: const TextStyle( color: CustomColor.purpleTersier)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ID Dampingan: ${item['reqid']}'),
                            Text('Gender: ${item['gender']}'),
                            Text('Fakultas: ${item['fakultas']}'),
                            Text('Kampus: ${item['kampus']}'),
                            Text('Angkatan: ${item['angkatan']}'),
                            Text('Media Kontak: ${item['mediakontak']}'),
                            Text('Kontak: ${item['kontak']}'),
                            Text('Sesi Pendampingan: ${item['sesi']}'),
                            const SizedBox(height: 8,),
                            Text('Nama Pendamping Sebaya: ${item['psname']}'),
                          ],
                        ),
                        trailing: const CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return ListTile(
                        title: Text(item['initial']),
                        subtitle: const Text('Error loading data'),
                      );
                    } else {
                      return ListTile(
                        title: Text(item['initial']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ID Dampingan: ${item['reqid']}'),
                            Text('Gender: ${item['gender']}'),
                            Text('Fakultas: ${item['fakultas']}'),
                            Text('Kampus: ${item['kampus']}'),
                            Text('Angkatan: ${item['angkatan']}'),
                            Text('Media Kontak: ${item['mediakontak']}'),
                            Text('Kontak: ${item['kontak']}'),
                            Text('Sesi Pendampingan: ${item['sesi']}'),
                            const SizedBox(height: 8,),
                            Text('Nama Pendamping Sebaya: ${item['psname']}'),
                            if (snapshot.data!)
                              const Text('Pendampingan pertama: DIJADWALKAN', style: TextStyle(color: Colors.green))
                            else
                              const Text('Pendampingan pertama: BELUM DIJADWALKAN', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _showUpdateDialog(context, item, provider);
                              },
                            ),
                            const SizedBox(width: 5),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                final confirmDelete = await _showDeleteConfirmationDialog(context);
                                if (confirmDelete) {
                                  await provider.deleteDampingan(item['reqid']);
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<bool> _showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: const Text('Apakah Anda yakin ingin menghapus dampingan ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 248, 146, 139)),
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    ) ?? false;
  }

  void _showUpdateDialog(BuildContext context, Map<String, dynamic> item, DampinganProvider provider) {
    final _formKey = GlobalKey<FormState>();
    String? initial = item['initial'];
    String? gender = item['gender'];
    String? fakultas = item['fakultas'];
    String? kampus = item['kampus'];
    int? angkatan = item['angkatan'];
    String? mediakontak = item['mediakontak'];
    String? kontak = item['kontak'];
    String? sesi = item['sesi'];
    String? psname = item['psname'];
    String? katakunci = item['katakunci'];
    String? katakunci2 = item['katakunci2'];

    PSUsersRepository repository = PSUsersRepository();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ubah Data Dampingan'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: initial,
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
                    onSaved: (value) {
                      initial = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: gender,
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
                      gender = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: fakultas,
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
                      fakultas = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: kampus,
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
                      kampus = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: angkatan?.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Angkatan',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (int.tryParse(value!) == null) {
                        return 'Angkatan harus berupa angka';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      angkatan = int.tryParse(value!);
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: mediakontak,
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
                      mediakontak = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Media Kontak tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: kontak,
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
                    onSaved: (value) {
                      kontak = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: katakunci,
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
                      katakunci = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kata Kunci tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String?>(
                    value: katakunci2,
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
                        child: Text(katakunci2 ?? "Pilih Kata Kunci Tambahan"),
                      );
                    }).toList(),
                    onChanged: (value) {
                      katakunci2 = value;
                    },
                    // No validator needed for optional field
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: sesi,
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
                      sesi = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Sesi tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  FutureBuilder<List<ActiveUser>>(
                    future: repository.fetchPSNames(), // Fungsi untuk mengambil data nama pendamping dari database
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
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  final newData = {
                    'initial': initial,
                    'gender': gender,
                    'fakultas': fakultas,
                    'kampus': kampus,
                    'angkatan': angkatan,
                    'mediakontak': mediakontak,
                    'kontak': kontak,
                    'sesi': sesi,
                    'psname': psname,
                    'katakunci': katakunci,
                    'katakunci2': katakunci2,
                  };

                  await provider.updateDampingan(item['reqid'], newData);

                  Navigator.of(context).pop();
                  Get.snackbar('Ubah Data Dampingan', 'Data Dampingan $initial berhasil diperbarui',
                    backgroundColor: Colors.green, colorText: Colors.white);  
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
