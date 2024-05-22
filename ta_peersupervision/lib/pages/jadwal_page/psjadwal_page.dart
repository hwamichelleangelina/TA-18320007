import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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

  TextEditingController mediaController = TextEditingController();
  TextEditingController reqidController = TextEditingController();

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
                decoration: const InputDecoration(labelText: 'Request ID Dampingan'),
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
                          child: Text('${event.initial}\nRequest ID: ${event.reqid}\nMedia Pendampingan: ${event.media}'),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _events.remove(event);
                            setState(() {
                              _events.remove(event);
                              Navigator.of(context).pop();
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
              } else if (reqidController.text.isNumericOnly) {
                setState(() {
                  events.add(Event(
                    date: date,
                    media: mediaController.text,
                    reqid: int.parse(reqidController.text),
                    initial: ""
                  ));
                });
                Navigator.of(context).pop();
              }
              else {

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
