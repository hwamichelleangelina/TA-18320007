// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class FillForm extends StatefulWidget {
  const FillForm({super.key});

  @override
  _FillFormState createState() => _FillFormState();
}

class _FillFormState extends State<FillForm> {
  List<String> data = ["Info 1", "Info 2", "Info 3"];
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: textEditingController1,
              decoration: const InputDecoration(labelText: 'Field 1'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: textEditingController2,
              decoration: const InputDecoration(labelText: 'Field 2'),
            ),
            const SizedBox(height: 20),
            const Text('Informasi dari List Data:'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data
                  .map((item) => Text(
                        item,
                        style: const TextStyle(fontSize: 16),
                      ))
                  .toList(),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Aksi yang diambil saat tombol simpan ditekan
                  String input1 = textEditingController1.text;
                  String input2 = textEditingController2.text;
                  // Lakukan sesuatu dengan inputan (misalnya menyimpannya)
                  print('Input 1: $input1');
                  print('Input 2: $input2');
                },
                child: const Text('Simpan'),
              ),
            ),
          ],
        ),
      );
  }
}
