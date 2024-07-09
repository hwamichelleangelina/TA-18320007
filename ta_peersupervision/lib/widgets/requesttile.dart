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
              title: const SelectableText('Detail Permintaan'),
              content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ListBody(
                  children: <Widget>[
                    SelectableText('Request ID: ${widget.dampingan.reqid}'),
                    SelectableText('Inisial Dampingan: ${widget.dampingan.initial}'),
                    SelectableText('Gender: ${widget.dampingan.gender}'),
                    SelectableText('Fakultas: ${widget.dampingan.fakultas}'),
                    SelectableText('Kampus: ${widget.dampingan.kampus}'),
                    SelectableText('Angkatan: ${widget.dampingan.angkatan}'),
                    SelectableText('Media Kontak: ${widget.dampingan.mediakontak}'),
                    SelectableText('Kontak: ${widget.dampingan.kontak}'),
                    SelectableText('Sesi Pendampingan: ${widget.dampingan.sesi}'),
                    SelectableText('Kata Kunci Masalah: ${widget.dampingan.katakunci}'),
                    const SizedBox(height: 16.0),

                    SelectableText('Nama Pendamping Sebaya: ${widget.dampingan.psname}'),
                    SelectableText('NIM Pendamping Sebaya: ${widget.dampingan.psnim}'),

                    const SizedBox(height: 16),
                    const SelectableText('Tanggal Pertemuan:'),
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
                      child: SelectableText(
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
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
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
        title: SelectableText(widget.dampingan.initial),
        subtitle: SelectableText(
          selectedDate == null
              ? ''
              : '${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}',
        ),
        onTap: () => _showRequestDialog(context),
      ),
    );
  }
}
