import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/bkbacknav_items.dart';
import 'package:ta_peersupervision/constants/bkbacknavigator_items.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/pages/home_page/bkhome_page.dart';
import 'package:ta_peersupervision/styles/style.dart';
import 'package:ta_peersupervision/widgets/logo.dart';
import 'package:ta_peersupervision/widgets/popup_logout.dart';

class HeaderBKReport extends StatelessWidget {
  const HeaderBKReport({super.key, this.onLogoTap, required this.onNavMenuTap});
  final VoidCallback? onLogoTap;
  final Function(int) onNavMenuTap;

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

                for (int i = 0; i < backNavBKTitles.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                
                    child: TextButton(
                      onPressed: () {
                        if (backNavBKTitles[i] != "Keluar") {
                          Navigator.push(
                        context,
                          MaterialPageRoute(builder: (context) => backNaviBK[i]),
                        );
                        }
                        else {
                          logoutDialog(context);
                        }
                      }, 
                      child: Text(
                        backNavBKTitles[i],
                        style: const TextStyle(
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