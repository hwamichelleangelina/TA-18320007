// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ta_peersupervision/api/provider/dampingan_provider.dart';
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
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await provider.deleteDampingan(item['reqid']);
                          },
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
}
