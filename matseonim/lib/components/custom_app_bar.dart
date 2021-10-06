import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/pages/new_request_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  bool showBackButton;

  CustomAppBar({Key? key, this.showBackButton = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:  Image.asset('images/logo_flat.png', fit: BoxFit.contain, width: 140),
      centerTitle: true,
      backgroundColor: Colors.blue[900],
      elevation: 1.0,
      leading: Builder(
        builder: (BuildContext context) {
          if (!showBackButton) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }
            );
          } else {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Get.back();
              }
            );
          }
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications_outlined,
            color: Colors.white,
          ),
          onPressed: () async {
            Get.back();
            await Get.to(RequestPage());
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
