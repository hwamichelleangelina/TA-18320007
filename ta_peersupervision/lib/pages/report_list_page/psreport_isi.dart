import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/size.dart';
import 'package:ta_peersupervision/pages/report_list_page/psreport_page.dart';
import 'package:ta_peersupervision/widgets/report_fillingform.dart';
import 'package:ta_peersupervision/widgets/bkheader_kembali.dart';
import 'package:ta_peersupervision/widgets/footer.dart';
import 'package:ta_peersupervision/widgets/header_mobile.dart';
import 'package:ta_peersupervision/widgets/psdrawer_mobile.dart';

class PSReportForm extends StatefulWidget {
  final String repname;  // Menerima data nama dari halaman tabel
  final String repps;
  final String repdate;
  final String repkeyword;

  const PSReportForm({super.key,
    required this.repname,
    required this.repps,
    required this.repdate,
    required this.repkeyword,});

  @override
  State<PSReportForm> createState() => _PSReportFormState();
}

class _PSReportFormState extends State<PSReportForm> {
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
          : const PSDrawerMobile(),

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
                  }, navi: const PSReportPage(),)

                else
                  PSHeaderMobile(
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