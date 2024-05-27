import 'package:flutter/material.dart';
import 'package:ta_peersupervision/api/shared_preferences/jadwal_data_manager.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/widgets/report_fillingform.dart';
import 'package:ta_peersupervision/widgets/footer.dart';

class PSReportForm extends StatefulWidget {
  final JadwalList jadwal;

  const PSReportForm({super.key,
    required this.jadwal,});

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
          appBar: AppBar(
            title: const Text(''),
          ),
          key: scaffoldKey,
          backgroundColor: CustomColor.purpleBg,

          body: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(height: 20,),

                // Isi Report
                FillingForm(jadwal: widget.jadwal),

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