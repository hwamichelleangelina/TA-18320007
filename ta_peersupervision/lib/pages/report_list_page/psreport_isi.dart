import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/widgets/report_fillingform.dart';
import 'package:ta_peersupervision/widgets/footer.dart';

class PSReportForm extends StatefulWidget {
  final String initial;  // Menerima data nama dari halaman tabel
  final String psname;
  final String tanggal;
  final String katakunci;
  final int reqid;
  final int jadwalid;

  const PSReportForm({super.key,
    required this.initial,
    required this.psname,
    required this.tanggal,
    required this.katakunci, required this.reqid, required this.jadwalid,});

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
            title: const Text('Laporan Proses Pendampingan'),
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
                FillingForm(
                  jadwalid: widget.jadwalid,
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