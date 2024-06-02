import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_peersupervision/constants/colors.dart';
import 'package:ta_peersupervision/constants/login_as_items.dart';
import 'package:ta_peersupervision/styles/style.dart';
import 'package:ta_peersupervision/widgets/logo.dart';

class HeaderLoginDesktop extends StatelessWidget {
  const HeaderLoginDesktop({super.key});

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
              left: 30,
            ),

            child: SiteLogo(onTap: (){}, naviHome: '/ps-login'),
          ),

          const Spacer(),

          for (int i = 0; i < loginTitles.length; i++)
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
          
              child: TextButton(
                onPressed: () {
                  if (loginTitles[i] == "Masuk sebagai PS ITB"){
                    Get.toNamed('/ps-login');
                  }
                  else {
                    Get.toNamed('/bk-login');
                  }    
          
                },  // Untuk ini gabisa taruh const di padding, onPressed jangan kasih const
                child: Text(
                  loginTitles[i],
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