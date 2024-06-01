import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/size.dart';
import 'package:ta_peersupervision/widgets/bkdrawer_mobile.dart';
import 'package:ta_peersupervision/widgets/bkheader_mobile.dart';
import 'package:ta_peersupervision/widgets/bkheader_report.dart';
import 'package:ta_peersupervision/widgets/bkreports_table.dart';
import 'package:ta_peersupervision/widgets/footer.dart';

class BKCekLaporan extends StatefulWidget {
  const BKCekLaporan({super.key});

  @override
  State<BKCekLaporan> createState() => _BKCekLaporanState();
}

class _BKCekLaporanState extends State<BKCekLaporan> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  final List<GlobalKey> navbarKeys = List.generate(4, (index) => GlobalKey());

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
          : const BKDrawerMobile(),

          body: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                if (constraints.maxWidth >= minDesktopWidth)
                // Main Container
                  HeaderBKReport(onNavMenuTap: (int navIndex){
                    // call function
                    scrollToSection(navIndex);
                  },)

                else
                  BKHeaderMobile(
                    onLogoTap: () {},
                    onMenuTap: () {
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),
                  
//                if (constraints.maxWidth >= minDesktopWidth)
                // Main Page
//                  const MainDesktop()
//                else
//                  const MainMobile(),

                const SizedBox(height: 30,),

                const Text('Laporan Pendampingan', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),

                const SizedBox(height: 10,),

                // Tabel bagian list laporannya
                const DataTableWithDownloadButton(),

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