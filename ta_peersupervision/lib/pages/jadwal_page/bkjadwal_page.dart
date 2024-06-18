// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ta_peersupervision/api/repository/event.dart';
import 'package:ta_peersupervision/api/repository/jadwal_repository.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/size.dart';
import 'package:ta_peersupervision/widgets/bkdrawer_mobile.dart';
import 'package:ta_peersupervision/widgets/bkheader_kembali.dart';
import 'package:ta_peersupervision/widgets/calendar_widget.dart';
import 'package:ta_peersupervision/widgets/footer.dart';
import 'package:ta_peersupervision/widgets/bkheader_mobile.dart';

class BKJadwalPage extends StatefulWidget {
  const BKJadwalPage({super.key});

  @override
  _BKJadwalPageState createState() => _BKJadwalPageState();
}

class _BKJadwalPageState extends State<BKJadwalPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  final List<GlobalKey> navbarKeys = List.generate(4, (index) => GlobalKey());

  Map<DateTime, List<MyJadwal>> jadwal = {};
  JadwalRepository repository = JadwalRepository();

  String formatDateSQL(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    try {
      Map<DateTime, List<MyJadwal>> fetchedEvents = await repository.fetchAllJadwal();
      setState(() {
        jadwal = fetchedEvents;
      });
    } catch (e) {
      //print('Failed to fetch events: $e');
      Get.snackbar('Jadwal Pendampingan', 'Belum ada Jadwal');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                  HeaderBKKembali(
                    onNavMenuTap: (int navIndex) {
                      scrollToSection(navIndex);
                    },
                    navi: '/bk-home',
                  )
                else
                  BKHeaderMobile(
                    onLogoTap: () {},
                    onMenuTap: () {
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),
                const SizedBox(height: 30),
                CalendarWidget(
                  onDaySelected: _showEventDialog,
                  jadwal: jadwal,
                  initialFocusedDay: DateTime.now(),
                ),
                const SizedBox(height: 30),
                const Footer(),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEventDialog(DateTime date, List<MyJadwal> events) {
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
                if (events.isEmpty)
                  const Text('Tidak ada pendampingan di hari ini')
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: events.map((event) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text('Nomor Jadwal: ${event.jadwalid}\n${event.initial} - ID Dampingan: ${event.reqid}\nPendamping Sebaya: ${event.psname}\nMedia Pendampingan: ${event.mediapendampingan}\n'),
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

  void scrollToSection(int navIndex) {
    if (navIndex == 3) {
      return;
    }

    final key = navbarKeys[navIndex];
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
