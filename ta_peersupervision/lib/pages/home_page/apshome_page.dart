import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/size.dart';
import 'package:ta_peersupervision/widgets/apsdrawer_mobile.dart';
import 'package:ta_peersupervision/widgets/apsmain_desktop.dart';
import 'package:ta_peersupervision/widgets/apsmain_mobile.dart';
import 'package:ta_peersupervision/widgets/footer.dart';
import 'package:ta_peersupervision/widgets/apsheader_desktop.dart';
import 'package:ta_peersupervision/widgets/apsheader_mobile.dart';
import 'package:ta_peersupervision/widgets/apsjadwal_desktop.dart';
import 'package:ta_peersupervision/widgets/apsjadwal_mobile.dart';
import 'package:ta_peersupervision/widgets/psreset_password.dart';

class APSHomePage extends StatefulWidget {
  const APSHomePage({super.key});

  @override
  State<APSHomePage> createState() => _APSHomePageState();
}

class _APSHomePageState extends State<APSHomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  final List<GlobalKey> navbarKeys = List.generate(4, (index) => GlobalKey());


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
          : const APSDrawerMobile(),

          body: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            child: Column(
              children: [

                if (constraints.maxWidth >= minDesktopWidth)
                // Main Container
                  HeaderDesktop(onNavMenuTap: (int navIndex){
                    // call function
                    scrollToSection(navIndex);
                  },)

                else
                  APSHeaderMobile(
                    // drawer: Buka di kiri
                    // endDrawer: Buka di kanan
 
                    onLogoTap: () {},
                    onMenuTap: () {
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),

                if (constraints.maxWidth >= minDesktopWidth)
                // Main Page
                  const APSMainDesktop()
                else
                  const APSMainMobile(),
                
                // Jadwal pendampingan
                Container(
                  key: navbarKeys.first,
                  width: screenWidth,
                  padding: const EdgeInsets.fromLTRB(25, 30, 25, 40),
                  color: CustomColor.purpleBg2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // title
                      const Text(
                        "Penjadwalan Pendampingan",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: CustomColor.whitePrimary,
                        ),
                      ),

                      const SizedBox(height: 30,),

                      if (constraints.maxWidth >= minDesktopWidth)
                        // Main Page
                        const APSJadwalDesktop()
                      else
                        const APSJadwalMobile(),
                    ],
                  ),
                ),

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
                      ResetPSPassword(),
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