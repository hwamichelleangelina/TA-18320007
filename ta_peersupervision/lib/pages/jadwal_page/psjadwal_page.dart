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
import 'package:ta_peersupervision/widgets/calendar_widget.dart';
import 'package:ta_peersupervision/widgets/footer.dart';
import 'package:ta_peersupervision/widgets/header_mobile.dart';
import 'package:ta_peersupervision/widgets/psdrawer_mobile.dart';
import 'package:ta_peersupervision/widgets/psheader_kembalihome.dart';

class PSJadwalPage extends StatefulWidget {
  final int psnim;

  const PSJadwalPage({super.key, required this.psnim});

  @override
  // ignore: library_private_types_in_public_api
  _PSJadwalPageState createState() => _PSJadwalPageState();
}

class _PSJadwalPageState extends State<PSJadwalPage> {
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
      // print('Failed to fetch events: $e');
      Get.snackbar('Jadwal Pendampingan', 'Belum ada Jadwal');
    }
  }

  @override
  void dispose() {
    reqidController.dispose();
    mediaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: CustomColor.purpleBg,
          endDrawer: constraints.maxWidth >= minDesktopWidth ? null : const PSDrawerMobile(),
          body: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (constraints.maxWidth >= minDesktopWidth)
                  HeaderPSBack(onNavMenuTap: (int navIndex) {
                    scrollToSection(navIndex);
                  })
                else
                  PSHeaderMobile(
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
    DateTime today = DateTime.now();
    bool isPastDate = selectedDate.isBefore(DateTime(today.year, today.month, today.day));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isPastDate
              ? 'Jadwal Pendampingan ${date.day}/${date.month}/${date.year}'
              : 'Tambahkan Jadwal Pendampingan ${date.day}/${date.month}/${date.year}'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isPastDate) ...[
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
                    decoration: const InputDecoration(labelText: 'Tempat Pendampingan'),
                  ),
                ],
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
                            child: SelectableText('${event.initial}\nID Dampingan: ${event.reqid}\nTempat Pendampingan: ${event.mediapendampingan}\n'),
                          ),
                          if (!isPastDate)
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                final confirmDelete = await _showDeleteConfirmationDialog(context, event.jadwalid);
                                if (confirmDelete) {
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
                                }
                              },
                            ),
                        ],
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
          actions: isPastDate
              ? <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Tutup'),
                  ),
                ]
              : <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      if (mediaController.text.isEmpty || reqidController.text.isEmpty) {
                        Get.snackbar('Rencanakan jadwal Pendampingan', 'Kolom harus terisi!',
                            backgroundColor: Colors.red, colorText: Colors.white);
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
                    child: const Text('Tutup'),
                  ),
                ],
        );
      },
    );
  }

  Future<bool> _showDeleteConfirmationDialog(BuildContext context, int jadwalid) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus jadwal pendampingan dengan ID: $jadwalid?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              child: const Text('Hapus'),
            ),
            const SizedBox(width: 10,),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Batal'),
            ),
          ],
        );
      },
    ) ?? false;
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