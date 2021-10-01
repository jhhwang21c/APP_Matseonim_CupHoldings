import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_drawer_header.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/pages/my_mhi_page.dart';
import 'package:matseonim/pages/my_msi_page.dart';
import 'package:matseonim/pages/my_profile_page.dart';
import 'package:matseonim/pages/request_page.dart';
import 'package:matseonim/pages/settings_page.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MSIUser.init(),
      builder: (BuildContext context, AsyncSnapshot<MSIUser> snapshot) {  
        final MSIUser? user = snapshot.data;

        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              CustomDrawerHeader(user: user),
              ListTile(
                title: const Text('내 정보'),
                onTap: () {
                  Get.to(MyProfilePage());
                }
              ),
              ListTile(
                title: const Text('내 맞선임'),
                onTap: () {
                  Get.to(MyMSIPage());
                }
              ),
              ListTile(
                title: const Text('내 맞후임'),
                onTap: () {
                  Get.to(MyMHIPage());
                }
              ),
              ListTile(
                title: const Text('새로운 의뢰'),
                onTap: () {
                  Get.to(RequestPage());
                }
              ),
              ListTile(
                title: const Text('환경설정'),
                onTap: () {
                  Get.to(SettingsPage());
                }
              )
            ]
          )
        );
      }
    );
  }
}
