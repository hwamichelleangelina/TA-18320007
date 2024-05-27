// ignore_for_file: avoid_print, collection_methods_unrelated_type

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
  // ignore: library_private_types_in_public_api
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
    // Mengambil nilai dari ReqidStorage dan mengatur nilai awal TextEditingController
    reqidController.text = ReqidStorage.getReqid().toString();
  }

Future<void> _fetchEvents(int psnim) async {
  try {
    Map<DateTime, List<MyJadwal>> fetchedEvents = await repository.fetchJadwal(widget.psnim);
    print('psnim fetchEvents: $psnim');
    print('Fetched Events: $fetchedEvents');

    setState(() {
      jadwal = fetchedEvents;
    });
    print('fetchEvents success');
    print('$fetchedEvents');
  } catch (e) {
    print('Failed to fetch events: $e');
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
          endDrawer: constraints.maxWidth >= minDesktopWidth
          ? null
          : const APSDrawerMobile(),
          
          body: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.vertical,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (constraints.maxWidth >= minDesktopWidth)
                // Main Container
                  HeaderAPSBack(onNavMenuTap: (int navIndex){
                    // call function
                    scrollToSection(navIndex);
                  },)

                else
                  APSHeaderMobile(
                    onLogoTap: () {},
                    onMenuTap: () {
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),

                const SizedBox(height: 30,),

                CalendarWidget(
                  onDaySelected: _showEventDialog,
                  focusedDay: DateTime.now(), jadwal: jadwal, initialFocusedDay: DateTime.now(),
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

void _showEventDialog(DateTime date, List<MyJadwal> events) {
  List<MyJadwal> selectedEvents = events.where((event) =>
      event.tanggal.year == date.year &&
      event.tanggal.month == date.month &&
      event.tanggal.day == date.day).toList();

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
                ]
              ),
              TextField(
                controller: mediaController,
                decoration: const InputDecoration(labelText: 'Media Pendampingan'),
              ),
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
                          child: Text('${event.initial}\nRequest ID: ${event.reqid}\nMedia Pendampingan: ${event.mediapendampingan}'),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            jadwal.remove(event);
                            setState(() {
                              jadwal.remove(event);
                              Navigator.pop(context);
                            });
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
              if (mediaController.text.isEmpty ||
                  reqidController.text.isEmpty) {
                Get.snackbar('Rencanakan jadwal Pendampingan', 'Kolom harus terisi!',
                    backgroundColor: Colors.red,
                    colorText: Colors.white);
              } else {

                Jadwal jadwal = Jadwal(
                    reqid: int.parse(reqidController.text),
                    tanggal: formatDateSQL(date),
                    mediapendampingan: mediaController.text
                  );

//                  print('SelectedDate: ${formatDateSQL(date)}');
//                  print("Date toIso8601String: ${date.toIso8601String()}");
//                  print('reqID: ${reqidController.text}');
                  repository.createJadwal(jadwal: jadwal).then((value) {
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
