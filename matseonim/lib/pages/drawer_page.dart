import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_drawer_header.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/pages/main_page.dart';
import 'package:matseonim/pages/my_mhi_page.dart';
import 'package:matseonim/pages/my_msi_page.dart';
import 'package:matseonim/pages/my_account_page.dart';
import 'package:matseonim/pages/request_page.dart';
import 'package:matseonim/pages/settings_page.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          FutureBuilder(
            future: MSIUser.init(),
            builder: (BuildContext context, AsyncSnapshot<MSIUser> snapshot) {
              if (!snapshot.hasData) {
                return SizedBox(
                  height: 160,
                  child: Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator()
                  )
                );
              } else {
                return CustomDrawerHeader(user: snapshot.data!);
              }
            }
          ),
          ListTile(
            title: const Text('홈 화면'),
            onTap: () async {
              Get.back();
              await Get.to(MainPage());
            }
          ),
          ListTile(
            title: const Text('내 정보'),
            onTap: () async {
              Get.back();
              await Get.to(MyAccountPage());
            }
          ),
          ListTile(
            title: const Text('내 맞선임'),
            onTap: () async {
              Get.back();
              await Get.to(MyMSIPage());
            }
          ),
          ListTile(
            title: const Text('내 맞후임'),
            onTap: () async {
              Get.back();
              await Get.to(MyMHIPage());
            }
          ),
          ListTile(
            title: const Text('새로운 의뢰'),
            onTap: () async {
              Get.back();
              await Get.to(RequestPage());
            }
          ),
          ListTile(
            title: const Text('환경설정'),
            onTap: () async {
              Get.back();
              await Get.to(SettingsPage());
            }
          ),
        ],
      )
    );
  }
}
