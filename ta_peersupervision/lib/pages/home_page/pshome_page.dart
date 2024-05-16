import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/size.dart';
import 'package:ta_peersupervision/widgets/footer.dart';
import 'package:ta_peersupervision/widgets/header_mobile.dart';
import 'package:ta_peersupervision/widgets/main_desktop.dart';
import 'package:ta_peersupervision/widgets/main_mobile.dart';
import 'package:ta_peersupervision/widgets/psdrawer_mobile.dart';
import 'package:ta_peersupervision/widgets/psheader_desktop.dart';
import 'package:ta_peersupervision/widgets/psjadwal_desktop.dart';
import 'package:ta_peersupervision/widgets/psjadwal_mobile.dart';
import 'package:ta_peersupervision/widgets/psreset_password.dart';

class PSHomePage extends StatefulWidget {
  const PSHomePage({super.key});

  @override
  State<PSHomePage> createState() => _PSHomePageState();
}

class _PSHomePageState extends State<PSHomePage> {
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
          : const PSDrawerMobile(),

          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                if (constraints.maxWidth >= minDesktopWidth)
                // Main Container
                  const PSHeaderDesktop()

                else
                  PSHeaderMobile(
 
                    onLogoTap: () {},
                    onMenuTap: () {
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),

                if (constraints.maxWidth >= minDesktopWidth)
                // Main Page
                  const MainDesktop()
                else
                  const MainMobile(),
                
                Container(
                  width: screenWidth,
                  padding: const EdgeInsets.fromLTRB(25, 30, 25, 40),
                  color: CustomColor.purpleBg2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // title
                      const Text(
                        "Jadwal Pendampingan PS",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: CustomColor.whitePrimary,
                        ),
                      ),

                      const SizedBox(height: 30,),

                      if (constraints.maxWidth >= minDesktopWidth)
                        // Main Page
                        const JadwalPSDesktop()
                      else
                        const JadwalPSMobile(),
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
}