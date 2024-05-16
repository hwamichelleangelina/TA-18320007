// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class FillingForm extends StatefulWidget {
  final bool isYesChecked;  // Status checkbox "Ya"
  final bool isNoChecked;   // Status checkbox "Tidak"
  final Function(bool, bool) onCheckboxChanged;  // Callback untuk perubahan checkbox

  final Function(String, String, String, String, bool) onSubmit;

  final String penname;  // Menerima data nama dari halaman tabel
  final String penps;
  final String pendate;
  final String penkeyword;

  const FillingForm({
    super.key,
    required this.isYesChecked,
    required this.isNoChecked,
    required this.onCheckboxChanged,
    required this.onSubmit,
    required this.penname,
    required this.penps,
    required this.pendate,
    required this.penkeyword,
  });

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

  String _gambar = '';
  String _proses = '';
  String _hasil = '';
  String _kendala = '';
  bool _isRujukan = false;

  @override
  Widget build(BuildContext context) {
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

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),  // Margin untuk judul,
            child: Text(
              'Inisial Dampingan: ${widget.penname}',
              style: const TextStyle(fontSize: 18,),
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),  // Margin untuk judul,
            child: Text(
              'Pendamping Sebaya: ${widget.penps}',
              style: const TextStyle(fontSize: 18,),
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),  // Margin untuk judul,
            child: Text(
              'Tanggal Pendampingan: ${widget.pendate}',
              style: const TextStyle(fontSize: 18,),
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),  // Margin untuk judul,
            child: Text(
              'Kata Kunci Masalah Dampingan: ${widget.penkeyword}',
              style: const TextStyle(fontSize: 18,),
            ),
          ),

          const SizedBox(height: 20),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),  // Margin untuk judul,
            child: Text(
              'Gambaran Permasalahan Dampingan',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                            _isRujukan = true;
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
                            _isRujukan = false;
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

          SizedBox(
            width: double.infinity*0.6,
            child: ElevatedButton(
              onPressed: () {
                if (gambarantextFieldController.text.isEmpty ||
                    prosestextFieldController.text.isEmpty ||
                    hasiltextFieldController.text.isEmpty ||
                    kendalatextFieldController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Harap isi semua kolom teks yang tersedia'),
                        backgroundColor: Color.fromARGB(255, 248, 146, 139), // Warna merah pada Snackbar
                      ),
                    );
                  }
                else {
                    widget.onSubmit(_gambar, _proses, _hasil, _kendala, _isRujukan);
                    Navigator.of(context).pop();
                    _showSnackbar(context, 'Laporan Proses Pendampingan Berhasil Disimpan');
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

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: const Color.fromARGB(255, 123, 217, 126), // Mengatur warna hijau
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}