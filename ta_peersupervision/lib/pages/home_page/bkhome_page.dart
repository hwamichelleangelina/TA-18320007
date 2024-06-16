import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/size.dart';
import 'package:ta_peersupervision/widgets/bkanggotaps_desktop.dart';
import 'package:ta_peersupervision/widgets/bkdrawer_mobile.dart';
import 'package:ta_peersupervision/widgets/bkheader_desktop.dart';
import 'package:ta_peersupervision/widgets/bklihatjadwal_desktop.dart';
import 'package:ta_peersupervision/widgets/bkmain_desktop.dart';
import 'package:ta_peersupervision/widgets/bkmain_mobile.dart';
import 'package:ta_peersupervision/widgets/footer.dart';
import 'package:ta_peersupervision/widgets/bkheader_mobile.dart';
import 'package:ta_peersupervision/widgets/reset_password.dart';

class BKHomePage extends StatefulWidget {
  const BKHomePage({super.key});

  @override
  State<BKHomePage> createState() => _BKHomePageState();
}

class _BKHomePageState extends State<BKHomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: CustomColor.purpleBg,
          endDrawer: constraints.maxWidth >= minDesktopWidth
          ? null
          : const BKDrawerMobile(),

          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                if (constraints.maxWidth >= minDesktopWidth)
                // Main Container
                  const HeaderBKDesktop()

                else
                  BKHeaderMobile(
                    // drawer: Buka di kiri
                    // endDrawer: Buka di kanan
 
                    onLogoTap: () {},
                    onMenuTap: () {
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),

                if (constraints.maxWidth >= minDesktopWidth)
                // Main Page
                  const BKMainDesktop()
                else
                  const BKMainMobile(),
          
                Container(
                  width: screenWidth,
                  padding: const EdgeInsets.fromLTRB(25, 30, 25, 40),
                  color: CustomColor.purpleBg2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // title
                      if (constraints.maxWidth >= minDesktopWidth)
                      const Text(
                        "Jadwal Pendampingan PS ITB",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: CustomColor.whitePrimary,
                        ),
                      )
                      else 
                      const Text(
                        "Lihat Jadwal PS ITB",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: CustomColor.whitePrimary,
                        ),
                      ),

                      const SizedBox(height: 30,),

                      const BKJadwal(),

                      
              ])),

                Container(
                  width: screenWidth,
                  padding: const EdgeInsets.fromLTRB(25, 30, 25, 40),
                  color: CustomColor.purpleBg,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // title
                      if (constraints.maxWidth >= minDesktopWidth)
                      const Text(
                        "Anggota Pendamping Sebaya ITB",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: CustomColor.whitePrimary,
                        ),
                      )
                      else 
                      const Text(
                        "Anggota PS ITB",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: CustomColor.whitePrimary,
                        ),
                      ),

                      const SizedBox(height: 30,),

                      // Main Page
                      const BKAnggotaPSITB(),

                      ])),

                Container(
                  width: screenWidth,
                  padding: const EdgeInsets.fromLTRB(25, 30, 25, 40),
                  color: const Color.fromARGB(255, 43, 45, 60),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // title
                      Text(
                        "Ingin mengganti Password?",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 177, 177, 177),
                        ),
                      ),

                      SizedBox(height: 30,),

                    //if (constraints.maxWidth >= minDesktopWidth)
                      // Main Page
                      ResetBKPassword(),
                    //else
                    //  const JadwalMobile() 
                    ],
                  ),
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
}