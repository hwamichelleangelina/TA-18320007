import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/size.dart';
import 'package:ta_peersupervision/pages/report_list_page/apsreport_page.dart';
import 'package:ta_peersupervision/widgets/apsdrawer_mobile.dart';
import 'package:ta_peersupervision/widgets/report_fillingform.dart';
import 'package:ta_peersupervision/widgets/bkheader_kembali.dart';
import 'package:ta_peersupervision/widgets/footer.dart';
import 'package:ta_peersupervision/widgets/apsheader_mobile.dart';

class APSReportForm extends StatefulWidget {

  final String repname;  // Menerima data nama dari halaman tabel
  final String repps;
  final String repdate;
  final String repkeyword;

  const APSReportForm({super.key,
    required this.repname,
    required this.repps,
    required this.repdate,
    required this.repkeyword,});

  @override
  State<APSReportForm> createState() => _APSReportFormState();
}

class _APSReportFormState extends State<APSReportForm> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  final List<GlobalKey> navbarKeys = List.generate(4, (index) => GlobalKey());

  bool isYesChecked = false;
  bool isNoChecked = false;

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
                  HeaderBKKembali(onNavMenuTap: (int navIndex){
                    // call function
                    scrollToSection(navIndex);
                  }, navi: const APSReportPage(),)

                else
                  APSHeaderMobile(
                    onLogoTap: () {},
                    onMenuTap: () {
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),

                const SizedBox(height: 30,),

                // Isi Report
                FillingForm(
                            penname: widget.repname,
                            penps: widget.repps,
                            pendate: widget.repdate,
                            penkeyword: widget.repkeyword,
                            isYesChecked: isYesChecked,
                            isNoChecked: isNoChecked,
                            onCheckboxChanged: (newYesValue, newNoValue) {
                              setState(() {
                                isYesChecked = newYesValue;
                                isNoChecked = newNoValue;
                              });
                            }, onSubmit: (gambar , proses , hasil , kendala , isRujukan , isAgree) {  },
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