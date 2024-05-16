// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:ta_peersupervision/api/logic/dampingan_logic.dart';

class RequestTile extends StatefulWidget {
  final Dampingan dampingan;
  final Color? tileColor;

  const RequestTile({super.key, required this.dampingan, this.tileColor});

  @override
  _RequestTileState createState() => _RequestTileState();
}

class _RequestTileState extends State<RequestTile> {
  DateTime? selectedDate;

  void _showRequestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Detail Permintaan'),
              content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ListBody(
                  children: <Widget>[
                    Text('Request ID: ${widget.dampingan.reqid}'),
                    Text('Inisial Dampingan: ${widget.dampingan.initial}'),
                    Text('Gender: ${widget.dampingan.gender}'),
                    Text('Fakultas: ${widget.dampingan.fakultas}'),
                    Text('Kampus: ${widget.dampingan.kampus}'),
                    Text('Angkatan: ${widget.dampingan.angkatan}'),
                    Text('Media Kontak: ${widget.dampingan.mediakontak}'),
                    Text('Kontak: ${widget.dampingan.kontak}'),
                    Text('Sesi Pendampingan: ${widget.dampingan.sesi}'),
                    Text('Kata Kunci Masalah: ${widget.dampingan.katakunci}'),
                    const SizedBox(height: 16.0),

                    Text('Nama Pendamping Sebaya: ${widget.dampingan.psname}'),
                    Text('NIM Pendamping Sebaya: ${widget.dampingan.psnim}'),

                    const SizedBox(height: 16),
                    const Text('Tanggal Pertemuan:'),
                    const SizedBox(height: 8.0),
                    OutlinedButton(
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                      child: Text(
                        selectedDate == null
                            ? 'Pilih Tanggal'
                            : '${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}',
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 248, 146, 139)),
                  ),
                  child: const Text('Batal'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Simpan'),
                  onPressed: () {
                    // Tambahkan logika penyimpanan di sini
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0), // Spasi antar tile
      decoration: BoxDecoration(
        color: widget.tileColor,
        borderRadius: BorderRadius.circular(12.0), // Edge curves
      ),
      child: ListTile(
        title: Text(widget.dampingan.initial),
        subtitle: Text(
          selectedDate == null
              ? ''
              : '${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}',
        ),
        onTap: () => _showRequestDialog(context),
      ),
    );
  }
}
