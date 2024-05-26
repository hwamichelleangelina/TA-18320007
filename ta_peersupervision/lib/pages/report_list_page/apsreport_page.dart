import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ta_peersupervision/api/provider/laporan_provider.dart';
import 'package:ta_peersupervision/api/shared_preferences/jadwal_data_manager.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/size.dart';
import 'package:ta_peersupervision/pages/report_list_page/apsreport_isi.dart';
import 'package:ta_peersupervision/widgets/apsdrawer_mobile.dart';
import 'package:ta_peersupervision/widgets/apsheader_kembalihome.dart';
import 'package:ta_peersupervision/widgets/apsreports_table.dart';
import 'package:ta_peersupervision/widgets/footer.dart';
import 'package:ta_peersupervision/widgets/apsheader_mobile.dart';

class APSReportPage extends StatefulWidget {
  const APSReportPage({super.key});

  @override
  State<APSReportPage> createState() => _APSReportPageState();
}

class _APSReportPageState extends State<APSReportPage> {
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
    Get.to (() => APSReportForm(jadwal: jadwal));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LaporanProvider>(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: CustomColor.purpleBg,
          endDrawer: constraints.maxWidth >= minDesktopWidth ? null : const APSDrawerMobile(),
          body: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                if (constraints.maxWidth >= minDesktopWidth)
                  HeaderAPSBack(
                    onNavMenuTap: (int navIndex) {
                      scrollToSection(navIndex);
                    },
                  )
                else
                  APSHeaderMobile(
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
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: _filteredJadwalList.length,
                              itemBuilder: (context, index) {
                                final bool checkLaporan = checkSnapshot.data![index]; // Mengambil nilai checkLaporan dari list hasil Future
                                if (checkLaporan == false) {
                                  return APSReportTable(
                                    checkLaporan: checkLaporan,
                                    jadwal: _filteredJadwalList[index],
                                    onTap: () => _navigateToForm(_filteredJadwalList[index]),
                                  );
                                }
                                else {
                                  return APSReportTable(
                                    checkLaporan: checkLaporan,
                                    jadwal: _filteredJadwalList[index],
                                    onTap: () {},
                                  );                                  
                                }
                              },
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
