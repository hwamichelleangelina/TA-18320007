import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/constants/apsbacknav_items.dart';
import 'package:ta_peersupervision/constants/apsbacknavigator_items.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/styles/style.dart';
import 'package:ta_peersupervision/widgets/logo.dart';
import 'package:ta_peersupervision/widgets/popup_logout.dart';

class HeaderAPSBack extends StatelessWidget {
  const HeaderAPSBack({super.key, this.onLogoTap, required this.onNavMenuTap});
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

                  child: SiteLogo(onTap: onLogoTap, naviHome: '/aps-home',
                  ),
                ),
                const Spacer(),

                for (int i = 0; i < backNavAPSTitles.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                
                    child: TextButton(
                      onPressed: () {
                        if (backNavAPSTitles[i] != "Keluar") {
                          Get.toNamed(backNaviAPS[i]
                        );
                        }
                        else {
                          logoutDialog(context);
                        }
                      }, 
                      child: Text(
                        backNavAPSTitles[i],
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