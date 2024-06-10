// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/api/repository/bkusers_repository.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/size.dart';

import 'package:ta_peersupervision/widgets/custom_text_field.dart';
import 'package:ta_peersupervision/widgets/drawer_login_mobile.dart';
import 'package:ta_peersupervision/widgets/footer.dart';
import 'package:ta_peersupervision/widgets/header_login_desktop.dart';
import 'package:ta_peersupervision/widgets/header_login_mobile.dart';
import 'package:ta_peersupervision/widgets/login_bktitle_desktop.dart';
import 'package:ta_peersupervision/widgets/login_bktitle_mobile.dart';

class BKLoginPage extends StatefulWidget {
  const BKLoginPage({super.key, required this.title});
  final String title;

  @override
  State<BKLoginPage> createState() => _BKLoginPageState();
}

class _BKLoginPageState extends State<BKLoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  final List<GlobalKey> navbarKeys = List.generate(2, (index) => GlobalKey());

  // Text Editing controllers
  final bkusernameController = TextEditingController();
  final bkpasswordhashController = TextEditingController();

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
                    // HEADER
                    if (constraints.maxWidth >= minDesktopWidth)
                    // Main Container
                      const HeaderLoginDesktop(
                      )
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

                    // TITLE FOR LOGIN
                    if (constraints.maxWidth >= minDesktopWidth)
                    // Main Container
                    const LoginBKTitleDesktop()
                    else
                      const LoginBKTitleMobile(),

                    const SizedBox(height: 10,),

                    // CONTENT
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
                                hintText: "Username Admin BK ITB",
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
                        if (bkusernameController.text.isEmpty || bkpasswordhashController.text.isEmpty) {
                          Get.snackbar('Login BK ITB', 'Semua kolom harus terisi!',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,);
                        }
                        else {
                          setState(() {
                            isLoading = true;
                          });
                            repository.loginBKUsers(bkusername: bkusernameController.text, bkpasswordhash: bkpasswordhashController.text).then((value) {
                              if (value == null) {
//                                print(value);
//                                print(bkusernameController.text);
//                                print(bkpasswordhashController.text); // Controller passed
                                Get.snackbar('Login Error', 'Username atau password akun Bimbingan Konseling ITB salah',
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,);
                                setState(() {
                                  isLoading = false;
                                });
                                Get.toNamed('/bk-login');
                              }
                              else {
                                setState(() {
                                  isLoading = false;
                                });
                                Get.toNamed('/bk-home');
                              }
                            });
                        }
                        },
                        child: const Text(
                          "Masuk Akun",
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
                        // Masih overflow
                        onPressed: () {
                          Get.toNamed('/bk-register');
                        },
                        child: const Text(
                          "Daftar Akun Admin BK ITB",
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

/*Route _createRoute(Widget child) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.linear;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}*/