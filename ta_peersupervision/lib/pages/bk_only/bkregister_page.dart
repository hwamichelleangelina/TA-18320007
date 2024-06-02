// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks, avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/api/logic/bkusers_logic.dart';
import 'package:ta_peersupervision/api/repository/bkusers_repository.dart';

import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/size.dart';

import 'package:ta_peersupervision/widgets/custom_text_field.dart';
import 'package:ta_peersupervision/widgets/drawer_login_mobile.dart';
import 'package:ta_peersupervision/widgets/footer.dart';
import 'package:ta_peersupervision/widgets/header_login_desktop.dart';
import 'package:ta_peersupervision/widgets/header_login_mobile.dart';
import 'package:ta_peersupervision/widgets/register_bktitle_desktop.dart';
import 'package:ta_peersupervision/widgets/register_bktitle_mobile.dart';

class BKRegisterPage extends StatefulWidget {
  const BKRegisterPage({super.key, required String title});

  @override
  State<BKRegisterPage> createState() => _BKRegisterPageState();
}

class _BKRegisterPageState extends State<BKRegisterPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController bkusernameController = TextEditingController();
  final TextEditingController bkpasswordhashController = TextEditingController();
  final TextEditingController bknameController = TextEditingController();
  final TextEditingController bknpmController = TextEditingController();

  BKUsersRepository repository = BKUsersRepository();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    /*
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    */

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: CustomColor.purpleBg,
          endDrawer: constraints.maxWidth >= minDesktopWidth
          ? null
          : const DrawerLoginMobile(),

          body: Center(
            child: isLoading
            ? Container(
              padding: const EdgeInsets.all(50),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 41, 3, 123),
                borderRadius: BorderRadius.circular(10),
              ),

              child: const Center(
                child: CircularProgressIndicator(),)
            )
            : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  if (constraints.maxWidth >= minDesktopWidth)
                  // Main Container
                    const HeaderLoginDesktop()
                  else
                    HeaderLoginMobile(
  
                      onLogoTap: (){},
                      onMenuTap: () {
                        scaffoldKey.currentState?.openEndDrawer();
                      },
                    ),
                  
                  /* if (constraints.maxWidth >= minDesktopWidth)
                  // Main Container
                    const LoginDesktop()

                  else
                    LoginMobile(), */

                  const SizedBox(height: 40),

                  if (constraints.maxWidth >= minDesktopWidth)
                  // Main Container
                  const RegisterBKTitleDesktop()
                  else
                    const RegisterBKTitleMobile(),

                  const SizedBox(height: 10,),

                  Container(
                    margin: const EdgeInsets.fromLTRB(30, 20, 30, 5),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Row (
                        children: [
                          // Nama Lengkap
                          Flexible(
                            child: CustomTextField(
                              controller: bknameController,
                              hintText: "Nama Lengkap",
                              obscureText: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.fromLTRB(30, 20, 30, 5),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Row (
                        children: [
                          // NPM
                          Flexible(
                            child: CustomTextField(
                              controller: bknpmController,
                              hintText: "NPM Admin BK ITB",
                              obscureText: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.fromLTRB(30, 20, 30, 5),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Row (
                        children: [
                          // NIM
                          Flexible(
                            child: CustomTextField(
                              controller: bkusernameController,
                              hintText: "Buat Username",
                              obscureText: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Password
                  Container(
                    margin: const EdgeInsets.fromLTRB(30, 20, 30, 5),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400,),
                        child: CustomTextField(
                                controller: bkpasswordhashController,
                                hintText: "Kata Sandi",
                                obscureText: true,
                              ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Submit
                  SizedBox(
                    width: 300,
                    height: 45.0,
                    child: ElevatedButton(
                      onPressed: (){
                        if (bknameController.text.isEmpty || bknpmController.text.isEmpty || 
                            bkusernameController.text.isEmpty || bkpasswordhashController.text.isEmpty) {
                          Get.snackbar('Registrasi BK ITB', 'Semua kolom harus terisi!',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,);
                        }
                        else {
                          setState(() {
                            isLoading = true;
                          });
                          BKUsers bkusers = BKUsers(
                            bkname: bknameController.text,
                            bknpm: int.tryParse(bknpmController.text) ?? 0,
                            bkusername: bkusernameController.text,
                            bkpasswordhash: bkpasswordhashController.text
                          );

                          repository.registerBKUsers(bkusers: bkusers).then((value) {
                            setState(() {
                              isLoading = false;
                            });
                            Get.toNamed('/bk-login');
                          });            
                        }
                      },
                      child: const Text(
                        "Daftarkan Admin BK ITB",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30,),

                  SizedBox(
                    width: 200,
                    height: 45.0,
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed('/bk-login');
                      },
                      child: const Text(
                        "Masuk Akun Admin BK ITB",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: CustomColor.whitePrimary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),

                  Container(height: 100,),


                  // Footer
                  const Footer(),

                  ],
                ),
              ),
            ),
          );
        },
    );
  }
}

/*
Route _createRoute(Widget child) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(2.0, 10.0);
      const end = Offset.zero;
      const curve = Curves.elasticIn;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
*/