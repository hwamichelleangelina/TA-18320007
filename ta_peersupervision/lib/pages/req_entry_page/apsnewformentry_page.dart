import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/size.dart';
import 'package:ta_peersupervision/widgets/apsdrawer_mobile.dart';
import 'package:ta_peersupervision/widgets/apsheader_kembali.dart';
import 'package:ta_peersupervision/widgets/apsheader_mobile.dart';
import 'package:ta_peersupervision/widgets/footer.dart';
import 'package:ta_peersupervision/widgets/noPSdampingan_list.dart';

class APSNewFormEntry extends StatefulWidget {
  const APSNewFormEntry({super.key});

  @override
  State<APSNewFormEntry> createState() => _APSNewFormEntryState();
}

class _APSNewFormEntryState extends State<APSNewFormEntry> {
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
          : const APSDrawerMobile(),

          body: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                if (constraints.maxWidth >= minDesktopWidth)
                // Main Container
                  HeaderAPSKembali(onNavMenuTap: (int navIndex){
                    // call function
                    scrollToSection(navIndex);
                  }, navi: '/aps-requests',)

                else
                  APSHeaderMobile(
                    onLogoTap: () {},
                    onMenuTap: () {
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),
                  
                const SizedBox(height: 30,),

                const NoPSDampinganList(),

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