import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/size.dart';
import 'package:ta_peersupervision/pages/anggota_page/bkdata_anggota_page.dart';
import 'package:ta_peersupervision/widgets/bkdrawer_mobile.dart';
import 'package:ta_peersupervision/widgets/bkheader_kembali.dart';
import 'package:ta_peersupervision/widgets/bktambah_anggota.dart';
import 'package:ta_peersupervision/widgets/footer.dart';
import 'package:ta_peersupervision/widgets/bkheader_mobile.dart';

class BKTambahAnggota extends StatefulWidget {
  const BKTambahAnggota({super.key});

  @override
  State<BKTambahAnggota> createState() => _BKTambahAnggotaState();
}

class _BKTambahAnggotaState extends State<BKTambahAnggota> {
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
                  HeaderBKKembali(onNavMenuTap: (int navIndex){
                    // call function
                    scrollToSection(navIndex);
                  }, navi: const BKDataAnggota(),)

                else
                  BKHeaderMobile(
                    onLogoTap: () {},
                    onMenuTap: () {
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),

                const SizedBox(height: 30,),

                // Tambah Data Anggota
                TambahAnggota(onSubmit: (nama, nim, password, isActive, isAdmin) {
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