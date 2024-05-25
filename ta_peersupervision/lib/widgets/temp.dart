/*import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class NameAndOriginFrequency extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {'name': 'John', 'origin': 'New York', 'arrivalDate': '1990-01-15'},
    {'name': 'Emily', 'origin': 'Los Angeles', 'arrivalDate': '1992-03-20'},
    {'name': 'Michael', 'origin': 'Chicago', 'arrivalDate': '1985-04-05'},
    {'name': 'Sophia', 'origin': 'New York', 'arrivalDate': '1995-01-10'},
    {'name': 'John', 'origin': 'New York', 'arrivalDate': '1993-03-25'},
    {'name': 'Sophia', 'origin': 'New York', 'arrivalDate': '1988-04-30'},
    {'name': 'Michael', 'origin': 'Chicago', 'arrivalDate': '1994-01-05'},
    {'name': 'Sophia', 'origin': 'New York', 'arrivalDate': '1990-03-15'},
    {'name': 'Emily', 'origin': 'Los Angeles', 'arrivalDate': '1992-07-20'},
    {'name': 'John', 'origin': 'New York', 'arrivalDate': '1989-08-02'},
    {'name': 'Michael', 'origin': 'Chicago', 'arrivalDate': '1994-09-12'},
    {'name': 'Sophia', 'origin': 'New York', 'arrivalDate': '1991-10-25'},
    {'name': 'John', 'origin': 'New York', 'arrivalDate': '1993-11-19'},
    {'name': 'Emily', 'origin': 'Los Angeles', 'arrivalDate': '1995-12-03'},
    {'name': 'Michael', 'origin': 'Chicago', 'arrivalDate': '1988-02-08'},
    {'name': 'Sophia', 'origin': 'New York', 'arrivalDate': '1996-05-15'},
    // Add more data from the database here
  ];

  Map<String, int> _calculateNameFrequency(List<Map<String, dynamic>> data) {
    Map<String, int> nameFrequencyMap = {};
    for (var item in data) {
      final name = item['name'];
      if (name != null) {
        nameFrequencyMap[name] = (nameFrequencyMap[name] ?? 0) + 1;
      }
    }
    return nameFrequencyMap;
  }

  Map<String, int> _calculateOriginFrequency(List<Map<String, dynamic>> data) {
    Map<String, int> originFrequencyMap = {};
    for (var item in data) {
      final origin = item['origin'];
      if (origin != null) {
        originFrequencyMap[origin] = (originFrequencyMap[origin] ?? 0) + 1;
      }
    }
    return originFrequencyMap;
  }

  Map<int, int> _calculateArrivalMonthFrequency(List<Map<String, dynamic>> data) {
    Map<int, int> arrivalMonthFrequencyMap = {};
    for (int i = 1; i <= 12; i++) {
      arrivalMonthFrequencyMap[i] = 0;
    }
    for (var item in data) {
      final arrivalDate = item['arrivalDate'];
      if (arrivalDate != null) {
        final month = DateTime.parse(arrivalDate).month;
        if (arrivalMonthFrequencyMap.containsKey(month)) {
          arrivalMonthFrequencyMap[month] = (arrivalMonthFrequencyMap[month] ?? 0) + 1;
        }
      }
    }
    return arrivalMonthFrequencyMap;
  }

  @override
  Widget build(BuildContext context) {
    final nameFrequencyMap = _calculateNameFrequency(data);
    final originFrequencyMap = _calculateOriginFrequency(data);
    final arrivalMonthFrequencyMap = _calculateArrivalMonthFrequency(data);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Name Frequency',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                ...nameFrequencyMap.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 8.0),
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text('${entry.key}: ${entry.value}'),
                        ),
                        SizedBox(width: 8.0), // Adding gap between each box
                      ],
                    ),
                  );
                }).toList(),
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
                SizedBox(height: 8.0), // Adding space to match the top margin of name frequency
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Origin Frequency',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Origin')),
                      DataColumn(label: Text('Frequency')),
                    ],
                    rows: originFrequencyMap.entries.map((entry) {
                      return DataRow(cells: [
                        DataCell(Text(entry.key ?? 'Unknown')),
                        DataCell(Text(entry.value.toString())),
                      ]);
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Arrival Month Frequency',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                AspectRatio(
                  aspectRatio: 3,
                  child: PieChart(
                    PieChartData(
                      sections: List.generate(
                        12,
                        (index) {
                          final month = index + 1;
                          return PieChartSectionData(
                            value: arrivalMonthFrequencyMap[month]?.toDouble(),
                            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                            title: '${arrivalMonthFrequencyMap[index]}',
                            radius: 100,
                          );
                        },
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 0,
                      centerSpaceColor: Colors.white,
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: List.generate(
                    12,
                    (index) {
                      final month = index + 1;
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                            ),
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            _getMonthName(month),
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }

}
*/
