// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ta_peersupervision/api/provider/laporan_provider.dart';
import 'package:ta_peersupervision/api/shared_preferences/jadwal_data_manager.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/size.dart';
import 'package:ta_peersupervision/pages/report_list_page/psreport_isi.dart';
import 'package:ta_peersupervision/widgets/footer.dart';
import 'package:ta_peersupervision/widgets/header_mobile.dart';
import 'package:ta_peersupervision/widgets/psdrawer_mobile.dart';
import 'package:ta_peersupervision/widgets/psheader_kembalihome.dart';
import 'package:ta_peersupervision/widgets/psreports_table.dart';
import 'package:http/http.dart' as http;

class PSReportPage extends StatefulWidget {
  const PSReportPage({super.key});

  @override
  State<PSReportPage> createState() => _PSReportPageState();
}

class _PSReportPageState extends State<PSReportPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  final List<GlobalKey> navbarKeys = List.generate(4, (index) => GlobalKey());

  late Future<List<JadwalList>> futureJadwal;
  List<JadwalList> _jadwalList = [];
  List<JadwalList> _filteredJadwalList = [];
  String _searchText = '';
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureJadwal = JadwalService.fetchJadwalReports();
    futureJadwal.then((jadwalList) {
      setState(() {
        _jadwalList = jadwalList;
        _filteredJadwalList = jadwalList;
      });
    });
  }

  void _filterJadwal(String query) {
    setState(() {
      _searchText = query.toLowerCase();
      _filteredJadwalList = _searchText.isEmpty
          ? _jadwalList
          : _jadwalList.where((jadwal) {
              return jadwal.jadwalid.toString().toLowerCase().contains(_searchText) ||
                  jadwal.reqid.toString().toLowerCase().contains(_searchText) ||
                  jadwal.initial!.toLowerCase().contains(_searchText) ||
                  jadwal.formattedTanggal.toLowerCase().contains(_searchText);
            }).toList();
    });
  }

  void _navigateToForm(JadwalList jadwal) {
    Get.to(() => PSReportForm(jadwal: jadwal));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LaporanProvider>(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: CustomColor.purpleBg,
          endDrawer: constraints.maxWidth >= minDesktopWidth ? null : const PSDrawerMobile(),
          body: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                if (constraints.maxWidth >= minDesktopWidth)
                  HeaderPSBack(
                    onNavMenuTap: (int navIndex) {
                      scrollToSection(navIndex);
                    },
                  )
                else
                  PSHeaderMobile(
                    onLogoTap: () {},
                    onMenuTap: () {
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),

                const SizedBox(height: 46),
                const Center(
                  child: Text(
                    'Proses Pendampingan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      labelText: 'Pencarian',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (query) => _filterJadwal(query),
                  ),
                ),
                const SizedBox(height: 30),

                FutureBuilder<List<JadwalList>>(
                  future: futureJadwal,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<Future<bool>> futureChecks = _filteredJadwalList.map((item) => provider.fetchCheckLaporan(item.jadwalid!)).toList();
                      return FutureBuilder<List<bool>>(
                        future: Future.wait(futureChecks),
                        builder: (context, checkSnapshot) {
                          if (checkSnapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator(); // Menampilkan loading jika masih menunggu Future diselesaikan
                          } else if (checkSnapshot.hasError) {
                            return Text("${checkSnapshot.error}"); // Menampilkan pesan error jika terjadi kesalahan
                          } else {
                            return Column(
                              children: List.generate(_filteredJadwalList.length, (index) {
                                final bool checkLaporan = checkSnapshot.data![index]; // Mengambil nilai checkLaporan dari list hasil Future
                                if (checkLaporan == false) {
                                  return PSReportsTable(
                                    checkLaporan: checkLaporan,
                                    jadwal: _filteredJadwalList[index],
                                    onTap: () => _navigateToForm(_filteredJadwalList[index]),
                                  );
                                } else {
                                  return PSReportsTable(
                                    checkLaporan: checkLaporan,
                                    jadwal: _filteredJadwalList[index],
                                    onTap: () => _showDetails(_filteredJadwalList[index]),
                                  );
                                }
                              }),
                            );
                          }
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}"); // Menampilkan pesan error jika terjadi kesalahan pada futureJadwal
                    }
                    return const CircularProgressIndicator(); // Menampilkan loading jika masih menunggu data futureJadwal
                  },
                ),

                const SizedBox(height: 30),
                const Footer(),
              ],
            ),
          ),
        );
      },
    );
  }

  String formattedTanggal(String tanggalString) {
    final DateTime dateTime = DateTime.parse(tanggalString);
    return DateFormat('d MMMM y', 'id').format(dateTime);
  }

  void _showDetails(JadwalList jadwal) async {
    int? jadwalId = jadwal.jadwalid;

    try {
      final response = await http.get(Uri.parse('http://localhost:3000/laporan/getLaporan/$jadwalId'));
      if (response.statusCode == 200) {
        final detail = json.decode(response.body);
        if (detail['report'] is List && detail['report'].isNotEmpty) {
          final report = detail['report'][0];
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Laporan Proses Pendampingan', textAlign: TextAlign.center,),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SelectableText('Inisial Dampingan: ${report['initial'] ?? 'N/A'}'),
                      const SizedBox(height: 5),
                      SelectableText('ID Dampingan: ${report['reqid'] ?? 'N/A'}'),
                      const SizedBox(height: 10),
                      const SizedBox(height: 5),
                      SelectableText('Pendamping Sebaya: ${report['psname'] ?? 'N/A'}'),
                      const SizedBox(height: 5),
                      SelectableText('NIM Pendamping Sebaya: ${report['psnim'] ?? 'N/A'}'),
                      const SizedBox(height: 5),
                      const SizedBox(height: 10),
                      SelectableText('Jadwal ID: ${report['jadwalid'] ?? 'N/A'}'),
                      const SizedBox(height: 5),
                      SelectableText('Tanggal Pendampingan: ${formattedTanggal(report['tanggalKonversi'])}'),
                      const SizedBox(height: 5),
                      const SizedBox(height: 10),
                      SelectableText('Direkomendasikan untuk Rujuk ke Psikolog: ${report['isRecommended'] == 1 ? 'PERLU SEGERA' : 'Tidak Perlu'}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                      const SizedBox(height: 5),
                      SelectableText('Kata Kunci Permasalahan: ${report['katakunci'] ?? 'N/A'}'),
                      const SizedBox(height: 5),
                      const SizedBox(height: 35),
                      const Center(
                        child: Text(
                          'Gambaran Permasalahan Dampingan',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SelectableText('${report['gambaran'] ?? 'N/A'}'),
                      const SizedBox(height: 35),
                      const Center(
                        child: Text(
                          'Proses Pendampingan yang Dilakukan',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SelectableText('${report['proses'] ?? 'N/A'}'),
                      const SizedBox(height: 35),
                      const Center(
                        child: Text(
                          'Hasil Akhir dari Proses Pendampingan',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SelectableText('${report['hasil'] ?? 'N/A'}'),
                      const SizedBox(height: 35),
                      const Center(
                        child: Text(
                          'Kendala selama Proses Pendampingan',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SelectableText('${report['kendala'] ?? 'N/A'}'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Tutup'),
                  ),
                ],
              );
            },
          );
        } else {
          print('Unexpected detail format: ${detail['report']}');
        }
      } else {
        print('Failed to load details');
      }
    } catch (e) {
      print('Error fetching details: $e');
    }
  }

  void scrollToSection(int navIndex) {
    if (navIndex == 3) {
      return;
    }

    final key = navbarKeys[navIndex];
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
