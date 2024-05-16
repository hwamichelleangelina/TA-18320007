import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ta_peersupervision/dummy/usereport_database.dart';

class TabelFrekuensi extends StatelessWidget {
  const TabelFrekuensi({super.key});

  Map<String, int> _calculateNameFrequency(List<Map<String, dynamic>> dataFromDatabase) {
    Map<String, int> nameFrequencyMap = {};
    for (var item in dataFromDatabase) {
      final psname = item['ps'];
      if (psname != null) {
        nameFrequencyMap[psname] = (nameFrequencyMap[psname] ?? 0) + 1;
      }
    }
    return nameFrequencyMap;
  }

  Map<String, int> _calculateKeywordFrequency(List<Map<String, dynamic>> dataFromDatabase) {
    Map<String, int> keywordFrequencyMap = {};
    for (var item in dataFromDatabase) {
      final katakunci = item['keyword'];
      if (katakunci != null) {
        keywordFrequencyMap[katakunci] = (keywordFrequencyMap[katakunci] ?? 0) + 1;
      }
    }
    return keywordFrequencyMap;
  }

  @override
  Widget build(BuildContext context) {
    final nameFrequencyMap = _calculateNameFrequency(dataFromDatabase);
    final keywordFrequencyMap = _calculateKeywordFrequency(dataFromDatabase);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 105.0, vertical: 20.0),
                  child: Text(
                    'Jumlah Penanganan Pendampingan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                ...nameFrequencyMap.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                    child : Row(
                      children: [
                        Container(
                          width: 300.0,
                          margin: const EdgeInsets.only(left: 100.0),
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: CustomColor.purpleTersier),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text('${entry.key}: ${entry.value}'),
                        ),
                       const SizedBox(height: 8.0),
                      ]
                    ),
                  );
                }),
              ],
            ),
          ),
        ),

        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Topik Permasalahan Dampingan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Kata Kunci Topik')),
                      DataColumn(label: Text('Frekuensi Kemunculan')),
                    ],
                    rows: keywordFrequencyMap.entries.map((entry) {
                      return DataRow(cells: [
                        DataCell(Text(entry.key)),
                        DataCell(Text(entry.value.toString())),
                      ]);
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}