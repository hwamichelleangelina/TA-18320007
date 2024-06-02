import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/login_icons_items.dart';

class DrawerLoginMobile extends StatelessWidget {
  const DrawerLoginMobile({super.key});

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

            for (int i = 0; i < rolesItems.length; i++)
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
                  if (rolesItems[i]["title"] == "Masuk sebagai PS ITB"){
                    Get.toNamed('/ps-login');
                  }
                  else {
                    Get.toNamed('/bk-login');
                  }  
                },
                leading: 
                Image.asset(
                  rolesItems[i]["img"],
                  width: 23.0,
                ),
                title: Text(
                  rolesItems[i]["title"],
                  style: const TextStyle(fontFamily: 'Montserrat',
                ),
                ),
              ),
          ],
        ),
      );
  }
}