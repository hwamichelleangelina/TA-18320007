// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ta_peersupervision/api/logic/jadwal_logic.dart';
import 'package:ta_peersupervision/api/repository/event.dart';
import 'package:ta_peersupervision/api/repository/jadwal_repository.dart';
import 'package:ta_peersupervision/api/shared_preferences/jadwal_data_manager.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/size.dart';
import 'package:ta_peersupervision/widgets/apsdrawer_mobile.dart';
import 'package:ta_peersupervision/widgets/apsheader_kembalihome.dart';
import 'package:ta_peersupervision/widgets/calendar_widget.dart';
import 'package:ta_peersupervision/widgets/footer.dart';
import 'package:ta_peersupervision/widgets/apsheader_mobile.dart';

class APSJadwalPage extends StatefulWidget {
  final int psnim;
  const APSJadwalPage({super.key, required this.psnim});

  @override
  _APSJadwalPageState createState() => _APSJadwalPageState();
}

class _APSJadwalPageState extends State<APSJadwalPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  final List<GlobalKey> navbarKeys = List.generate(4, (index) => GlobalKey());

  Map<DateTime, List<MyJadwal>> jadwal = {};

  TextEditingController mediaController = TextEditingController();
  TextEditingController reqidController = TextEditingController();

  JadwalRepository repository = JadwalRepository();

  String formatDateSQL(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  @override
  void initState() {
    super.initState();
    _fetchEvents(widget.psnim);
    reqidController.text = ReqidStorage.getReqid().toString();
  }

  Future<void> _fetchEvents(int psnim) async {
    try {
      Map<DateTime, List<MyJadwal>> fetchedEvents = await repository.fetchJadwal(widget.psnim);
      setState(() {
        jadwal = fetchedEvents;
      });
    } catch (e) {
   //   print('Failed to fetch events: $e');
      Get.snackbar('Jadwal Pendampingan', 'Gagal mengambil data event');
    }
  }

  @override
  void dispose() {
    reqidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: CustomColor.purpleBg,
          endDrawer: constraints.maxWidth >= minDesktopWidth ? null : const APSDrawerMobile(),
          body: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (constraints.maxWidth >= minDesktopWidth)
                  HeaderAPSBack(onNavMenuTap: (int navIndex) {
                    scrollToSection(navIndex);
                  })
                else
                  APSHeaderMobile(
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
    DateTime selectedDate = DateTime(date.year, date.month, date.day);
 //   print(selectedDate);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambahkan Jadwal Pendampingan ${date.day}/${date.month}/${date.year}'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: reqidController,
                  decoration: const InputDecoration(labelText: 'ID Dampingan'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                TextField(
                  controller: mediaController,
                  decoration: const InputDecoration(labelText: 'Media Pendampingan'),
                ),
                const SizedBox(height: 16),
                const Text('Pendampingan Hari Ini:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                if (events.isEmpty)
                  const Text('Tidak ada pendampingan di hari ini', style: TextStyle(color: Color.fromARGB(255, 227, 152, 147)))
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: events.map((event) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text('${event.initial}\nID Dampingan: ${event.reqid}\nMedia Pendampingan: ${event.mediapendampingan}\n'),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              // Menghapus event dari map terlebih dahulu
                              setState(() {
                                jadwal[selectedDate]?.remove(event);
                                if (jadwal[selectedDate]?.isEmpty ?? false) {
                                  jadwal.remove(selectedDate);
                                }
                              });
                              // Menghapus event dari repository
                              await repository.deleteJadwal(event.jadwalid);
                              // Mengambil ulang data dari repository
                              await _fetchEvents(widget.psnim);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                if (mediaController.text.isEmpty || reqidController.text.isEmpty) {
                  Get.snackbar('Rencanakan jadwal Pendampingan', 'Kolom harus terisi!',
                      backgroundColor: Colors.red,
                      colorText: Colors.white);
                } else {
                  Jadwal jadwal = Jadwal(
                    reqid: int.parse(reqidController.text),
                    tanggal: formatDateSQL(date),
                    mediapendampingan: mediaController.text,
                  );

                  repository.createJadwal(jadwal: jadwal).then((value) {
                    _fetchEvents(widget.psnim);
                    Navigator.of(context).pop();
                  });
                  reqidController.clear();
                  mediaController.clear();
                }
              },
              child: const Text('Simpan'),
            ),
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
