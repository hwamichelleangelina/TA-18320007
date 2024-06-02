// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ta_peersupervision/api/logic/stats_logic.dart';
import 'package:ta_peersupervision/api/repository/stats_repository.dart';
import 'package:ta_peersupervision/constants/colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final StatsRepository repository = StatsRepository();

  late Future<List<SessionPerMonth>> sessionsPerMonth;
  late Future<List<TopPSDampingan>> topMentorsClients;
  late Future<List<TopPSJadwal>> topMentorsSessions;
  late Future<Map<String, List<ClientDistribution>>> clientDistribution;
  late Future<List<Topic>> topTopics;
  late Future<List<Recommendation>> recommendationRatio;

  @override
  void initState() {
    super.initState();
    sessionsPerMonth = repository.getSessionsPerMonth();
    topMentorsClients = repository.getTopPSDampingan();
    topMentorsSessions = repository.getTopPSJadwal();
    clientDistribution = repository.getClientDistribution();
    topTopics = repository.getTopTopics();
    recommendationRatio = repository.getRecommendationRatio();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 5.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
              color: CustomColor.purpleTersier,
            ),),
            const SizedBox(height: 5.0),
            _buildSectionTitle('Jadwal Pendampingan per Bulan'),
            _buildSessionsPerMonthChart(),
            const SizedBox(height: 20.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
              color: CustomColor.purpleTersier,
            ),),
            const SizedBox(height: 20.0),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  // Wide screen layout
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Center(
                                child: _buildSectionTitle('Peringkat Pendamping dengan Dampingan Terbanyak'),
                              ),
                            ),
                            _buildTopMentorsClientsTable(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Center(
                                child: _buildSectionTitle('Peringkat Pendamping dengan Jadwal Terbanyak'),
                              ),
                            ),
                            _buildTopMentorsSessionsTable(),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  // Narrow screen layout
                  return Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: _buildSectionTitle('Peringkat Pendamping dengan Dampingan Terbanyak'),
                            ),
                          ),
                          _buildTopMentorsClientsTable(),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: _buildSectionTitle('Peringkat Pendamping dengan Jadwal Terbanyak'),
                            ),
                          ),
                          _buildTopMentorsSessionsTable(),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 20.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
              color: CustomColor.purpleTersier,
            ),),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: _buildSectionTitle('Sebaran Fakultas, Kampus, Angkatan, dan Gender Dampingan'),
              ),
            ),
            const SizedBox(height: 10.0),
            _buildClientDistributionCharts(),
            const SizedBox(height: 40.0),
            _buildSectionTitle('Topik Permasalahan Dampingan Terpopuler'),
            _buildTopTopicsTable(),
            const SizedBox(height: 40.0),
            _buildSectionTitle('Perbandingan Potensi Rujukan Dampingan'),
            _buildRecommendationRatioChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildSessionsPerMonthChart() {
    return FutureBuilder<List<SessionPerMonth>>(
      future: sessionsPerMonth,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No data available');
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 300,
              child: charts.BarChart(
                [
                  charts.Series<SessionPerMonth, String>(
                    id: 'SessionsPerMonth',
                    colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
                    domainFn: (SessionPerMonth spm, _) => spm.month,
                    measureFn: (SessionPerMonth spm, _) => spm.count,
                    data: snapshot.data!,

                    labelAccessorFn: (SessionPerMonth spm, _) => '${spm.count}',
                  ),
                ],
                primaryMeasureAxis: const charts.NumericAxisSpec(
                  renderSpec: charts.GridlineRendererSpec(
                    // Customize gridline style
                    labelStyle: charts.TextStyleSpec(
                      fontFamily: 'Montserrat',
                      color: charts.MaterialPalette.white,
                    ),
                    lineStyle: charts.LineStyleSpec(
                      color: charts.MaterialPalette.white, // Gridline color
                    ),
                  ),
                ),
                barRendererDecorator: charts.BarLabelDecorator<String>(
                  labelAnchor: charts.BarLabelAnchor.end, 
                  labelPosition: charts.BarLabelPosition.outside, 
                  outsideLabelStyleSpec: const charts.TextStyleSpec(
                    fontFamily: 'Montserrat',
                    color: charts.MaterialPalette.white,
                  ),
              ),
            ),
          )
          );
        }
      },
    );
  }

  Widget _buildTopMentorsClientsTable() {
    return FutureBuilder<List<TopPSDampingan>>(
      future: topMentorsClients,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No data available');
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Nama Pendamping')),
                DataColumn(label: Text('Jumlah Dampingan')),
              ],
              rows: snapshot.data!
                  .map((mentor) => DataRow(cells: [
                        DataCell(Text(mentor.psname)),
                        DataCell(Text(mentor.dampingancount.toString())),
                      ]))
                  .toList(),
            ),
          );
        }
      },
    );
  }

  Widget _buildTopMentorsSessionsTable() {
    return FutureBuilder<List<TopPSJadwal>>(
      future: topMentorsSessions,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No data available');
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Nama Pendamping')),
                DataColumn(label: Text('Jumlah Jadwal')),
              ],
              rows: snapshot.data!
                  .map((mentor) => DataRow(cells: [
                        DataCell(Text(mentor.psname)),
                        DataCell(Text(mentor.jadwalcount.toString())),
                      ]))
                  .toList(),
            ),
          );
        }
      },
    );
  }

  Widget _buildClientDistributionCharts() {
    return FutureBuilder<Map<String, List<ClientDistribution>>>(
      future: clientDistribution,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No data available');
        } else {
          final fakultasData = snapshot.data!['fakultas'] ?? [];
          final kampusData = snapshot.data!['kampus'] ?? [];
          final angkatanData = snapshot.data!['angkatan'] ?? [];
          final genderData = snapshot.data!['gender'] ?? [];

          return LayoutBuilder(
            builder: (context, constraints) {
              bool isWideScreen = constraints.maxWidth > 900;
              return isWideScreen 
              ? GridView.count(
                crossAxisCount: 2, // Jumlah kolom dalam grid
                crossAxisSpacing: 5.0, // Jarak horizontal antara item
                mainAxisSpacing: 8.0, // Jarak vertikal antara item
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: isWideScreen ? 2.0 : 1.0, // Atur rasio lebar:tinggi untuk setiap item
                children: [
                  _buildPieChart('Sebaran Fakultas', fakultasData),
                  _buildPieChart('Sebaran Kampus', kampusData),
                  _buildPieChart('Sebaran Angkatan', angkatanData),
                  _buildPieChart('Sebaran Gender', genderData),
                ],
              )
              : Column(
                    children: [
                      _buildPieChart('Sebaran Fakultas', fakultasData),
                      const SizedBox(height: 10.0),
                      _buildPieChart('Sebaran Kampus', kampusData),
                      const SizedBox(height: 10.0),
                      _buildPieChart('Sebaran Angkatan', angkatanData),
                      const SizedBox(height: 10.0),
                      _buildPieChart('Sebaran Gender', genderData),
                    ],
                  );
            },
          );
        }
      },
    );
  }

  Widget _buildPieChart(String title, List<ClientDistribution> data) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 300,
          child: charts.PieChart<String>(
            [
              charts.Series<ClientDistribution, String>(
                id: title,
                colorFn: (_, idx) => charts.MaterialPalette.getOrderedPalettes(data.length)[idx!.toInt()].shadeDefault,
                domainFn: (ClientDistribution dist, _) => dist.category,
                measureFn: (ClientDistribution dist, _) => dist.count,
                data: data,
                labelAccessorFn: (ClientDistribution row, _) => '${row.category}: ${row.count}',
              ),
            ],
            animate: true,
            defaultRenderer: charts.ArcRendererConfig<String>(
              arcRendererDecorators: [
                charts.ArcLabelDecorator<String>(
                  insideLabelStyleSpec: const charts.TextStyleSpec(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    color: charts.MaterialPalette.white,
                  ),
                  outsideLabelStyleSpec: const charts.TextStyleSpec(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    color: charts.MaterialPalette.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopTopicsTable() {
    return FutureBuilder<List<Topic>>(
      future: topTopics,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No data available');
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Topik Permasalahan')),
                DataColumn(label: Text('Jumlah')),
              ],
              rows: snapshot.data!
                  .map((topic) => DataRow(cells: [
                        DataCell(Text(topic.katakunci)),
                        DataCell(Text(topic.count.toString())),
                      ]))
                  .toList(),
            ),
          );
        }
      },
    );
  }

  Widget _buildRecommendationRatioChart() {
    return FutureBuilder<List<Recommendation>>(
      future: recommendationRatio,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No data available');
        } else {
          final List<charts.Series<Recommendation, String>> seriesList = [
            charts.Series<Recommendation, String>(
              id: 'RecommendationRatio',
              colorFn: (Recommendation r, _) => r.isRecommended == 1
                  ? charts.MaterialPalette.red.shadeDefault
                  : charts.MaterialPalette.green.shadeDefault,
              domainFn: (Recommendation r, _) => r.isRecommended == 1 ? 'Dirujuk' : 'Tidak Dirujuk',
              measureFn: (Recommendation r, _) => r.count,
              data: snapshot.data!,
              labelAccessorFn: (Recommendation r, _) =>
                  '${r.isRecommended == 1 ? 'Dirujuk' : 'Tidak Dirujuk'}: ${r.count}',
            ),
          ];

          return SizedBox(
            height: 300,
            child: charts.PieChart<String>(
              seriesList,
              animate: true,
              defaultRenderer: charts.ArcRendererConfig<String>(
                arcRendererDecorators: [
                  charts.ArcLabelDecorator<String>(
                    insideLabelStyleSpec: const charts.TextStyleSpec(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      color: charts.MaterialPalette.white,
                    ),
                    outsideLabelStyleSpec: const charts.TextStyleSpec(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      color: charts.MaterialPalette.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
