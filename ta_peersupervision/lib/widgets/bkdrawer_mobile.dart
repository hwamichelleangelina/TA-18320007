import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/constants/bknav_icons_items.dart';
import 'package:ta_peersupervision/constants/bknavigator_items_mobile.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/widgets/popup_logout.dart';

class BKDrawerMobile extends StatelessWidget {
  const BKDrawerMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: CustomColor.purpleBg,
        child: ListView(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 20,
                  bottom: 20,
                ),

                child: IconButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ),

            for (int i = 0; i < naviBKItems.length; i++)
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 10.0,
                ),
                titleTextStyle: const TextStyle(
                  color: CustomColor.whitePrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                onTap: () {
                  if (naviBKItems[i]["title"] != "Keluar") {
                  Get.toNamed(naviBKmobile[i]);
                  }
                  else {
                    logoutDialog(context);
                  }
                },
                leading: 
                Image.asset(
                  naviBKItems[i]["img"],
                  width: 23.0,
                ),
                title: Text(
                  naviBKItems[i]["title"],
                  style: const TextStyle(fontFamily: 'Montserrat',
                ),
                ),
              ),
          ],
        ),
      );
  }
}