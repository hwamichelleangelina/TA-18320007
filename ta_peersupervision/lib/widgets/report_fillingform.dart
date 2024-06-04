// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_import, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ta_peersupervision/api/logic/jadwal_logic.dart';
import 'package:ta_peersupervision/api/logic/laporan_logic.dart';
import 'package:ta_peersupervision/api/provider/laporan_provider.dart';
import 'package:ta_peersupervision/api/repository/laporan_repository.dart';
import 'package:ta_peersupervision/api/shared_preferences/jadwal_data_manager.dart';
import 'package:ta_peersupervision/pages/report_list_page/apsreport_page.dart';

class FillingForm extends StatefulWidget {
  final JadwalList jadwal;

  const FillingForm({super.key, required this.jadwal});

  @override
  State<FillingForm> createState() => _FillingFormState();
}

class _FillingFormState extends State<FillingForm> {
  final TextEditingController gambarantextFieldController = TextEditingController();
  final TextEditingController prosestextFieldController = TextEditingController();
  final TextEditingController hasiltextFieldController = TextEditingController();
  final TextEditingController kendalatextFieldController = TextEditingController();
  bool isYesChecked = false;
  bool isNoChecked = false;
  bool isAgreeChecked = false;

  LaporanRepository repository = LaporanRepository();

  String _gambar = '';
  String _proses = '';
  String _hasil = '';
  String _kendala = '';
  bool _isRecommended = false;
  bool _isAgree = false;
  int isAgree = 0;
  int isRecommended = 0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LaporanProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),  // Margin untuk judul,
            child: Text(
              textAlign: TextAlign.center,
              'Laporan Proses Pendampingan',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 40),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),  // Margin untuk judul,
            child: Text(
              'ID Dampingan: ${widget.jadwal.reqid}',
              style: const TextStyle(fontSize: 18,),
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),  // Margin untuk judul,
            child: Text(
              'Inisial Dampingan: ${widget.jadwal.initial}',
              style: const TextStyle(fontSize: 18,),
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),  // Margin untuk judul,
            child: Text(
              'Pendamping Sebaya: ${widget.jadwal.psname}',
              style: const TextStyle(fontSize: 18,),
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),  // Margin untuk judul,
            child: Text(
              'ID Jadwal: ${widget.jadwal.jadwalid}',
              style: const TextStyle(fontSize: 18,),
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),  // Margin untuk judul,
            child: Text(
              'Tanggal Pendampingan: ${widget.jadwal.formattedTanggal}',
              style: const TextStyle(fontSize: 18,),
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),  // Margin untuk judul,
            child: Text(
              'Kata Kunci Masalah Dampingan: ${widget.jadwal.katakunci}',
              style: const TextStyle(fontSize: 18,),
            ),
          ),

          const SizedBox(height: 50),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),  // Margin untuk judul,
            child: Text(
              'Gambaran Permasalahan Dampingan',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 10.0),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30.0), // Margin horizontal
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _gambar = value;
                  });
                },
                controller: gambarantextFieldController,
                decoration: const InputDecoration(
                  hintText: 'Tuliskan gambaran permasalahan dampingan...',
                  border: InputBorder.none,
                ),
                maxLines: null,
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),  // Margin untuk judul,
            child: Text(
              'Proses Pendampingan yang Dilakukan',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 10.0),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30.0), // Margin horizontal
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _proses = value;
                  });
                },
                controller: prosestextFieldController,
                decoration: const InputDecoration(
                  hintText: 'Tuliskan proses pendampingan yang dilakukan...',
                  border: InputBorder.none,
                ),
                maxLines: null,
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),  // Margin untuk judul,
            child: Text(
              'Hasil Akhir dari Proses Pendampingan',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 10.0),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30.0), // Margin horizontal
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _hasil = value;
                  });
                },
                controller: hasiltextFieldController,
                decoration: const InputDecoration(
                  hintText: 'Tuliskan hasil akhir dari proses pendampingan...',
                  border: InputBorder.none,
                ),
                maxLines: null,
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),  // Margin untuk judul,
            child: Text(
              'Kendala Selama Pendampingan',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 10.0),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30.0), // Margin horizontal
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _kendala = value;
                  });
                },
                controller: kendalatextFieldController,
                decoration: const InputDecoration(
                  hintText: 'Tuliskan kendala selama pendampingan...',
                  border: InputBorder.none,
                ),
                maxLines: null,
              ),
            ),
          ),

          const SizedBox(height: 30.0),
          
          Center(  // Judul checkbox dan isinya berada di tengah
            child: Column(
              children: [
                const Text(
                  'Direkomendasikan untuk rujuk ke Psikolog?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
            
                const SizedBox(height: 10),

                Row(  // Baris untuk checkbox "Ya" dan "Tidak"
                mainAxisAlignment: MainAxisAlignment.center,  // Menjaga checkbox tetap di tengah
                children: [
                    Checkbox(
                      value: isYesChecked,
                      onChanged: (bool? newValue) {
                        setState(() {
                          isYesChecked = newValue!;  // Atur status checkbox "Ya"
                          if (isYesChecked) {
                            isNoChecked = false;  // Uncheck checkbox "Tidak" jika "Ya" dicentang
                            _isRecommended = true;
                          }
                        });
                      },
                    ),
                    const Text('Ya'),

                    const SizedBox(width: 10.0),

                    Checkbox(
                      value: isNoChecked,
                      onChanged: (bool? newValue) {
                        setState(() {
                          isNoChecked = newValue!;  // Atur status checkbox "Tidak"
                          if (isNoChecked) {
                            isYesChecked = false;  // Uncheck checkbox "Ya" jika "Tidak" dicentang
                            _isRecommended = false;
                          }
                        });
                      },
                    ),
                    const Text('Tidak'),
                  ],
                ),
              ]
            ),
          ),

          const SizedBox(height: 30.0),
          
          Center(  // Judul checkbox dan isinya berada di tengah
            child: Column(
              children: [
                Text(
                  'Saya, ${widget.jadwal.psname}, pendamping sebaya yang mendampingi ${widget.jadwal.initial} dengan sadar menyatakan bahwa pengisian laporan dan rekomendasi tindak lanjut selama kegiatan pendampingan telah diberitahukan kepada ${widget.jadwal.initial} dan ${widget.jadwal.initial} secara sadar menyetujui tindakan tersebut. Apabila terdapat tindak lanjut pendampingan, dampingan telah mengizinkan akses informasi pribadi dampingan oleh psikolog dan tenaga medis terkait.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15),
                ),
            
                const SizedBox(height: 10),

                Row(  // Baris untuk checkbox "Ya" dan "Tidak"
                mainAxisAlignment: MainAxisAlignment.center,  // Menjaga checkbox tetap di tengah
                children: [
                    Checkbox(
                      value: isAgreeChecked,
                      onChanged: (bool? newValue) {
                        setState(() {
                          isAgreeChecked = newValue!;  // Atur status checkbox "Ya"
                          _isAgree = true;

                          if (_isAgree == true) {
                            isAgree = 1;
                          }
                        });
                      },
                    ),
                    const Text('Saya menyetujui'),
                  ],
                ),
              ]
            ),
          ),

          const SizedBox(height: 30.0),

          SizedBox(
            width: double.infinity*0.6,
            child: ElevatedButton(
              onPressed: () async {
                if (gambarantextFieldController.text.isEmpty ||
                    prosestextFieldController.text.isEmpty ||
                    hasiltextFieldController.text.isEmpty ||
                    kendalatextFieldController.text.isEmpty) {
                      Get.snackbar('Pengisian Laporan Pendampingan', 'Harap isi semua kolom teks yang tersedia',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,); 
                    }
                else {
                  confirmationDialog(context);
                  await provider.fetchJadwalReport();
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 19.0, horizontal: 32.0),
                textStyle: const TextStyle(fontSize: 15.0, fontFamily: 'Montserrat'),
              ),
              child: const Text('Simpan'),
            ),
          ),
        ],
      ),
    );
  }

  void confirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Simpan Laporan Pendampingan'),
          content: const Text('Apakah laporan sudah benar?\nLaporan proses pendampingan TIDAK dapat diubah.'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                if (_isRecommended == true) {
                  isRecommended = 1;
                }
                else {
                  isRecommended = 0;
                }

                Laporan laporan = Laporan(
                  jadwalid: widget.jadwal.jadwalid,
                  isRecommended: isRecommended,
                  isAgree: isAgree,
                  gambaran: _gambar,
                  proses: _proses,
                  kendala: _kendala,
                  hasil: _hasil
                );

                repository.fillLaporan(laporan: laporan).then((value) async {
                  Navigator.of(context).pop();
                  Get.toNamed('/aps-laporan');
                }); 
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
      },
    );
  }
}