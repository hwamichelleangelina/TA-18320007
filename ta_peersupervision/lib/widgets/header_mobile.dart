import 'package:flutter/material.dart';
import 'package:ta_peersupervision/styles/style.dart';
import 'package:ta_peersupervision/widgets/logo.dart';

class PSHeaderMobile extends StatelessWidget {
  const PSHeaderMobile({super.key, this.onLogoTap, this.onMenuTap});
  final VoidCallback? onLogoTap;
  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 5),

      decoration: headerDeco,

      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
            ),
            
            child: SiteLogo(onTap: onLogoTap, naviHome: '/ps-home',
            ),
          ),

          const Spacer(),

          IconButton(
            onPressed: onMenuTap, 
            icon: const Icon(Icons.menu),
          ),

          const SizedBox(width: 15
          ),
        ]
      ),
    );
  }
}