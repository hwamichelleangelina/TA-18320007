import 'package:flutter/material.dart';
import 'package:ta_peersupervision/api/shared_preferences/jadwal_data_manager.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/size.dart';
import 'package:ta_peersupervision/widgets/footer.dart';
import 'package:ta_peersupervision/widgets/header_mobile.dart';
import 'package:ta_peersupervision/widgets/psdrawer_mobile.dart';
import 'package:ta_peersupervision/widgets/psheader_kembalihome.dart';
import 'package:ta_peersupervision/widgets/psreports_table.dart';

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
//    Get.to (() => APSReportForm(jadwal: jadwal));
  }

  @override
  Widget build(BuildContext context) {
//    final screenSize = MediaQuery.of(context).size;
//    final screenWidth = screenSize.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: CustomColor.purpleBg,
          endDrawer: constraints.maxWidth >= minDesktopWidth
          ? null
          : const PSDrawerMobile(),

          body: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                if (constraints.maxWidth >= minDesktopWidth)
                // Main Container
                  HeaderPSBack(onNavMenuTap: (int navIndex){
                    // call function
                    scrollToSection(navIndex);
                  },)

                else
                  PSHeaderMobile(
                    onLogoTap: () {},
                    onMenuTap: () {
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Pencarian',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          _filterJadwal('');
                        },
                      ),
                    ),
                    onChanged: (query) => _filterJadwal(query),
                  ),
                ),
                const SizedBox(height: 30),

                // List Laporan yang sudah dan perlu diisi
                FutureBuilder<List<JadwalList>>(
                  future: futureJadwal,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: _filteredJadwalList.length,
                        itemBuilder: (context, index) {
                          return PSReportsTable(
                            jadwal: _filteredJadwalList[index],
                            onTap: () => _navigateToForm(_filteredJadwalList[index]),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return const CircularProgressIndicator();
                  },
                ),

                const SizedBox(height: 30,),
                // Footer
                const Footer(),

              ],
            ),
          ),
        );
      },
    );
  }

  void scrollToSection(int navIndex){
    if (navIndex == 3){
      // 
      return;
    }

    final key = navbarKeys[navIndex];
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: 
        const Duration(milliseconds: 500), 
        curve: Curves.easeInOut,
      );
  }

}