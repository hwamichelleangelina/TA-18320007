import 'package:flutter/material.dart';
import 'package:ta_peersupervision/pages/jadwal_page/apsjadwal_page.dart';

class DampinganSaya extends StatelessWidget {
  const DampinganSaya({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dampingan Saya'),
      ),
      body: ListView(
        children: [
          _buildSupportTile('John Doe', 'Male', context),
          _buildSupportTile('Jane Doe', 'Female', context),
          // Tambahkan list tile button lainnya di sini sesuai dengan data yang dimiliki
        ],
      ),
    );
  }

  Widget _buildSupportTile(String name, String gender, BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(gender),
      onTap: () {
        _showSupportDetailsDialog(name, gender, context);
      },
    );
  }

  void _showSupportDetailsDialog(String name, String gender, BuildContext context) {
    // Buat pop up dialog untuk menampilkan detail pendamping
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(name),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Gender: $gender'),
              // Tambahkan field lainnya seperti Fakultas, Angkatan, dll. di sini
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Buat jadwal temu'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const APSJadwalPage()),
                );
              },
              child: const Text('Tutup', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
