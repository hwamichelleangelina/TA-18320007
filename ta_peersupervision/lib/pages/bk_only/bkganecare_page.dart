// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:ta_peersupervision/api/ganecare_API/api_service.dart';

class BKGanecarePage extends StatefulWidget {
  const BKGanecarePage({super.key});

  @override
  _BKGanecarePageState createState() => _BKGanecarePageState();
}

class _BKGanecarePageState extends State<BKGanecarePage> {
  final GanecareService service = GanecareService();
  List<dynamic> rooms = [];
  List<dynamic> users = [];
  List<dynamic> genderRoleComparison = [];
  List<dynamic> roleComparison = [];
  List<dynamic> inaIdRanking = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    rooms = await service.fetchRooms();
    users = await service.fetchUsers();
    genderRoleComparison = await service.fetchGenderRoleComparison();
    roleComparison = await service.fetchRoleComparison();
    inaIdRanking = await service.fetchInaIdRanking();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ganecare Supervision'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSection('Rooms', rooms),
            buildSection('Users', users),
            buildSection('Gender Role Comparison', genderRoleComparison),
            buildSection('Role Comparison', roleComparison),
            buildSection('INA ID Ranking', inaIdRanking),
          ],
        ),
      ),
    );
  }

  Widget buildSection(String title, List<dynamic> data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          data.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(data[index].toString()),
                      ),
                    );
                  },
                )
              : const CircularProgressIndicator(),
        ],
      ),
    );
  }
}