import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/api/repository/psusers_repository.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/size.dart';
import 'package:ta_peersupervision/widgets/custom_text_field.dart';
import 'package:ta_peersupervision/widgets/drawer_login_mobile.dart';
import 'package:ta_peersupervision/widgets/footer.dart';
import 'package:ta_peersupervision/widgets/header_login_desktop.dart';
import 'package:ta_peersupervision/widgets/header_login_mobile.dart';
import 'package:ta_peersupervision/widgets/login_title_desktop.dart';
import 'package:ta_peersupervision/widgets/login_title_mobile.dart';

class PSLoginPage extends StatefulWidget {
  const PSLoginPage({super.key});

  @override
  State<PSLoginPage> createState() => _PSLoginPageState();
}

class _PSLoginPageState extends State<PSLoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final psnimController = TextEditingController();
  final pspasswordhashController = TextEditingController();

  PSUsersRepository repository = PSUsersRepository();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
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
                      child: CircularProgressIndicator(),
                    ),
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
                            onLogoTap: () {},
                            onMenuTap: () {
                              scaffoldKey.currentState?.openEndDrawer();
                            },
                          ),
                        const SizedBox(height: 40),
                        if (constraints.maxWidth >= minDesktopWidth)
                          // Main Container
                          const LoginTitleDesktop()
                        else
                          const LoginTitleMobile(),
                        const SizedBox(height: 10),
                        Container(
                          margin: const EdgeInsets.fromLTRB(30, 20, 30, 5),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 400),
                            child: Row(
                              children: [
                                // NIM
                                Flexible(
                                  child: CustomTextField(
                                    controller: psnimController,
                                    hintText: "NIM Mahasiswa",
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
                            constraints: const BoxConstraints(maxWidth: 400),
                            child: CustomTextField(
                              controller: pspasswordhashController,
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
                            onPressed: () {
                              if (psnimController.text.isEmpty ||
                                  pspasswordhashController.text.isEmpty) {
                                Get.snackbar(
                                  'Login PS ITB',
                                  'Semua kolom harus terisi!',
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                              } else {
                                setState(() {
                                  isLoading = true;
                                });
                                repository
                                    .loginPSUsers(
                                        psnim: int.parse(psnimController.text),
                                        pspasswordhash:
                                            pspasswordhashController.text)
                                    .then((value) {
                                  if (value == null) {
                                    Get.snackbar(
                                      'Login Error',
                                      'Username atau password akun PS ITB salah',
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                                    setState(() {
                                      isLoading = false;
                                    });
                                  } else if (value.psisAdmin == 1) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Get.offNamed('/aps-home');
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Get.offNamed('/ps-home');
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
                        const SizedBox(height: 30),
                        const SizedBox(
                          height: 45.0,
                        ),
                        Container(
                          height: 100,
                        ),
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
