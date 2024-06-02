import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/constants/bkanggotapsnav_page_items.dart';
import 'package:ta_peersupervision/constants/bkanggotapsnavigator_items.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/styles/style.dart';
import 'package:ta_peersupervision/widgets/logo.dart';
import 'package:ta_peersupervision/widgets/popup_logout.dart';

class HeaderBKAnggota extends StatelessWidget {
  const HeaderBKAnggota({super.key, this.onLogoTap, required this.onNavMenuTap});
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

                  child: SiteLogo(onTap: onLogoTap, naviHome: '/bk-home',
                  ),
                ),
                const Spacer(),

                for (int i = 0; i < anggotaNavBKTitles.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                
                    child: TextButton(
                      onPressed: () {
                        if (anggotaNavBKTitles[i] != "Keluar") {
                          Get.toNamed(anggotaNaviBK[i]);
                        }
                        else {
                          logoutDialog(context);
                        }
                      }, 
                      child: Text(
                        anggotaNavBKTitles[i],
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