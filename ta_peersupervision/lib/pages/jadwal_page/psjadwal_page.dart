import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/event.dart';
import 'package:ta_peersupervision/constants/size.dart';
import 'package:ta_peersupervision/widgets/calendar_widget.dart';
import 'package:ta_peersupervision/widgets/footer.dart';
import 'package:ta_peersupervision/widgets/header_mobile.dart';
import 'package:ta_peersupervision/widgets/psdrawer_mobile.dart';
import 'package:ta_peersupervision/widgets/psheader_kembalihome.dart';

class PSJadwalPage extends StatefulWidget {
  const PSJadwalPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PSJadwalPageState createState() => _PSJadwalPageState();
}

class _PSJadwalPageState extends State<PSJadwalPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  final List<GlobalKey> navbarKeys = List.generate(4, (index) => GlobalKey());

  final List<Event> _events = [
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
          : const PSDrawerMobile(),
          
          body: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.vertical,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (constraints.maxWidth >= minDesktopWidth)
                // Main Container
                  HeaderPSBack(onNavMenuTap: (int navIndex){
                    // call function
                    scrollToSection(navIndex);
                  },)

                else
                  PSHeaderMobile(
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

  TextEditingController initialController = TextEditingController();
  TextEditingController peerSupportController = TextEditingController();

  String? selectedMedia; // Variabel untuk menyimpan media pendampingan yang dipilih

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
                controller: initialController,
                decoration: const InputDecoration(labelText: 'Inisial Dampingan'),
              ),
              DropdownButtonFormField(
                value: selectedMedia,
                onChanged: (newValue) {
                  setState(() {
                    selectedMedia = newValue;
                  });
                },
                items: ['WA', 'Line', 'Email']
                    .map((String media) {
                      return DropdownMenuItem(
                        value: media,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05, // Menetapkan tinggi setiap item
                          child: Center(child: Text(media)),
                        ),
                      );
                    })
                    .toList(),
                decoration: const InputDecoration(labelText: 'Media Pendampingan'),
              ),
              TextField(
                controller: peerSupportController,
                decoration: const InputDecoration(labelText: 'Pendamping Sebaya'),
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
                          child: Text('${event.initial} - ${event.peerSupport}\nMedia Pendampingan: ${event.media}'),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _events.remove(event);
                            setState(() {
                              _events.remove(event);
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
              if (initialController.text.isEmpty ||
                  selectedMedia == null ||
                  peerSupportController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Harap isi semua kolom teks yang tersedia'),
                    backgroundColor: Color.fromARGB(255, 248, 146, 139), // Warna merah pada Snackbar
                  ),
                );
              } else {
                setState(() {
                  events.add(Event(
                    date: date,
                    initial: initialController.text,
                    media: selectedMedia ?? '', // Menetapkan nilai default jika selectedMedia bernilai null,
                    peerSupport: peerSupportController.text,
                  ));
                });
                Navigator.of(context).pop();
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
