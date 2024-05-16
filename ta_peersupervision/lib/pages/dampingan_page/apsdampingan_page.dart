// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/size.dart';
import 'package:ta_peersupervision/widgets/apsdampingan_list.dart';
import 'package:ta_peersupervision/widgets/apsdrawer_mobile.dart';
import 'package:ta_peersupervision/widgets/apsheader_kembalihome.dart';
import 'package:ta_peersupervision/widgets/apsheader_mobile.dart';
import 'package:ta_peersupervision/widgets/footer.dart';

class APSDampinganPage extends StatefulWidget {

  const APSDampinganPage({super.key});

  @override
  State<APSDampinganPage> createState() => _APSDampinganPageState();
}

class _APSDampinganPageState extends State<APSDampinganPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  final List<GlobalKey> navbarKeys = List.generate(4, (index) => GlobalKey());

  int psnim = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    final screenSize = MediaQuery.of(context).size;
//    final screenWidth = screenSize.width;

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

                const Text('Dampingan Saya', textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),),

                const SizedBox(height: 30,),

                DampinganList(psnim: psnim),

/*
                // List Dampingan Saya
                SizedBox(
                  height: constraints.maxHeight - 50, // or a fixed height
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0), // Tambahkan padding di sini
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                      final dampinganMap = requests[index]; // Ambil map dari list requests
                      final dampingan = Dampingan.fromJson(dampinganMap); // Konversi map menjadi objek Dampingan
                        return RequestTile(
                          tileColor: index % 2 == 0
                              ? const Color.fromARGB(255, 55, 36, 72)
                              : const Color.fromARGB(255, 58, 45, 70),
                          dampingan: dampingan, // Gunakan request untuk mengisi RequestTile
                        );
                      },
                    ),
                  ),
                ),
*/

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
