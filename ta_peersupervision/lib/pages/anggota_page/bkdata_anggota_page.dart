import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/size.dart';
import 'package:ta_peersupervision/widgets/bkdata_anggota_table.dart';
import 'package:ta_peersupervision/widgets/bkdata_anggotanonaktif_table.dart';
import 'package:ta_peersupervision/widgets/bkdrawer_mobile.dart';
import 'package:ta_peersupervision/widgets/bkheader_dataanggota.dart';
import 'package:ta_peersupervision/widgets/footer.dart';
import 'package:ta_peersupervision/widgets/bkheader_mobile.dart';

class BKDataAnggota extends StatefulWidget {
  const BKDataAnggota({super.key});

  @override
  State<BKDataAnggota> createState() => _BKDataAnggotaState();
}

class _BKDataAnggotaState extends State<BKDataAnggota> {
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
                  HeaderBKAnggota(onNavMenuTap: (int navIndex){
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

                const SizedBox(height: 30,),

                // Data Anggota
                DataTableAnggota(onSubmit: (nama, nim, password, psisActive, psisAdmin) {
                },),

                const SizedBox(height: 40,),

                const Text('Anggota Non-aktif', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),

                const SizedBox(height: 10,),

                DataTableAnggotaNonAktif(onSubmit: (nama, nim, password, psisActive, psisAdmin) {
                },),

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