import 'package:flutter/material.dart';
import 'package:ta_peersupervision/api/shared_preferences/jadwal_data_manager.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/widgets/report_fillingform.dart';
import 'package:ta_peersupervision/widgets/footer.dart';

class APSReportForm extends StatefulWidget {

  final JadwalList jadwal;

  const APSReportForm({super.key,
    required this.jadwal});

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
/*                  jadwalid: widget.jadwalid,
                  reqid: widget.reqid,
                  initial: widget.initial,
                  psname: widget.psname,
                  tanggal: widget.tanggal,
                  katakunci: widget.katakunci,
                  isYesChecked: isYesChecked,
                  isNoChecked: isNoChecked,
                  onCheckboxChanged: (newYesValue, newNoValue) {
                    setState(() {
                      isYesChecked = newYesValue;
                      isNoChecked = newNoValue;
                    });
                  }, onSubmit: (jadwalid, reqid, gambar , proses , hasil , kendala , isRecommended , isAgree) {  },
                ),*/

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