import 'package:flutter/material.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/psnav_items.dart';
import 'package:ta_peersupervision/constants/psnavigator_items.dart';
import 'package:ta_peersupervision/pages/home_page/pshome_page.dart';
import 'package:ta_peersupervision/styles/style.dart';
import 'package:ta_peersupervision/widgets/logo.dart';
import 'package:ta_peersupervision/widgets/popup_logout.dart';

class PSHeaderDesktop extends StatelessWidget {
  const PSHeaderDesktop({super.key, this.onLogoTap});
  final VoidCallback? onLogoTap;

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

                  child: SiteLogo(onTap: onLogoTap, naviHome: const PSHomePage(), 
                  ),
                ),
                // Jadikan widget Logo juga
                /*
                GestureDetector(
                  onTap: () {},
                  child:
                    const Text("Peer Supervision",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: CustomColor.yellowSecondary,
                      ),
                    ),
                ),
                */
                const Spacer(),

                for (int i = 0; i < navPSTitles.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                
                    child: TextButton(
                      // Masih overflow
                      onPressed: () {
                        if (navPSTitles[i] != "Keluar") {
                          Navigator.push(
                        context,
                          MaterialPageRoute(builder: (context) => naviPS[i]),
                        );
                        }
                        else {
                          logoutDialog(context);
                        }
                      }, 
                      child: Text(
                        navPSTitles[i],
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