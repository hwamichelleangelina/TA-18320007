import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/event.dart';
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

  final List<Event> _events = [
    Event(
      date: DateTime.now().add(const Duration(days: 1)),
      initial: 'ABC',
      media: 'WhatsApp',
      peerSupport: 'John Doe',
    ),
  ];

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

                CalendarWidget(
                  onDaySelected: _showEventDialog,
                  events: _events, focusedDay: DateTime.now(),
                ),

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

void _showEventDialog(DateTime date, List<Event> events) {
  List<Event> selectedEvents = events.where((event) =>
      event.date.year == date.year &&
      event.date.month == date.month &&
      event.date.day == date.day).toList();

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
                          child: Text('${event.initial} - ${event.peerSupport}\nMedia Pendampingan: ${event.media}'),
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
