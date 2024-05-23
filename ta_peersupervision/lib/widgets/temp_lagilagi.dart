/*import 'package:flutter/material.dart';
import 'package:ta_peersupervision/pages/jadwal_page/apsjadwal_page.dart';

class SupportTile extends StatelessWidget {
  final String name;
  final String gender;

  const SupportTile({
    required this.name,
    required this.gender,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(gender),
      onTap: () {
        _showSupportDetailsDialog(context);
      },
    );
  }

  void _showSupportDetailsDialog(BuildContext context) {
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
              // Add other fields like Faculty, Batch, etc. here
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
*/