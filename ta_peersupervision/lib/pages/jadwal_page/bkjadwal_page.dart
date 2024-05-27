import 'package:flutter/material.dart';
import 'package:ta_peersupervision/api/repository/event.dart';
import 'package:ta_peersupervision/api/repository/jadwal_repository.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/size.dart';
import 'package:ta_peersupervision/pages/home_page/bkhome_page.dart';
import 'package:ta_peersupervision/widgets/bkdrawer_mobile.dart';
import 'package:ta_peersupervision/widgets/bkheader_kembali.dart';
import 'package:ta_peersupervision/widgets/calendar_widget.dart';
import 'package:ta_peersupervision/widgets/footer.dart';
import 'package:ta_peersupervision/widgets/bkheader_mobile.dart';

class BKJadwalPage extends StatefulWidget {
  const BKJadwalPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BKJadwalPageState createState() => _BKJadwalPageState();
}

class _BKJadwalPageState extends State<BKJadwalPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  final List<GlobalKey> navbarKeys = List.generate(4, (index) => GlobalKey());

  Map<DateTime, List<MyJadwal>> jadwal = {};
  JadwalRepository repository = JadwalRepository();


  
  @override
  Widget build(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (constraints.maxWidth >= minDesktopWidth)
                // Main Container
                  HeaderBKKembali(onNavMenuTap: (int navIndex){
                    // call function
                    scrollToSection(navIndex);
                  }, navi: const BKHomePage(),)

                else
                  BKHeaderMobile(
                    onLogoTap: () {},
                    onMenuTap: () {
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),

                const SizedBox(height: 30,),

      /*          CalendarWidget(
                  onDaySelected: _showEventDialog,
                  focusedDay: DateTime.now(), jadwal: jadwal, initialFocusedDay: DateTime.now(),
                ),*/

                const SizedBox(height: 30,),
                // Footer
                const Footer(),

              ],
            ),
          ),
        );
      }
   );
  }

void _showEventDialog(DateTime date, List<MyJadwal> events) {
  List<MyJadwal> selectedEvents = events.where((event) =>
      event.tanggal.year == date.year &&
      event.tanggal.month == date.month &&
      event.tanggal.day == date.day).toList();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Jadwal Pendampingan ${date.day}/${date.month}/${date.year}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text('Pendampingan Hari Ini:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              if (selectedEvents.isEmpty)
                const Text('Tidak ada pendampingan di hari ini')
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: selectedEvents.map((event) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text('${event.initial}\nMedia Pendampingan: ${event.mediapendampingan}'),
                        ),
                      ],
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Tutup', style: TextStyle(color: Colors.red)),
          ),
        ],
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
