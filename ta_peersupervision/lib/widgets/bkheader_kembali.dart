import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/pages/home_page/bkhome_page.dart';
import 'package:ta_peersupervision/styles/style.dart';
import 'package:ta_peersupervision/widgets/logo.dart';

class HeaderBKKembali extends StatelessWidget {
  const HeaderBKKembali({super.key, this.onLogoTap, required this.onNavMenuTap, required this.navi});
  final VoidCallback? onLogoTap;
  final Function(int) onNavMenuTap;
  final Widget navi;

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 60.0,
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 5),
            width: double.maxFinite,
            decoration: headerDeco,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),

                  child: SiteLogo(onTap: onLogoTap, naviHome: const BKHomePage(),
                  ),
                ),
                const Spacer(),

                for (int i = 0; i < 1; i++)
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                            MaterialPageRoute(builder: (context) => navi),
                          );
                        },
                      child: const Text(
                        'Kembali',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: CustomColor.whitePrimary,
                        ),
                      ),
                    ),
                  ),
                ],
            ),
    );
  }
}