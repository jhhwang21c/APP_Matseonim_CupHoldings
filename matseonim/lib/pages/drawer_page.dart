import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_circle_avatar.dart';
import 'package:matseonim/database/msi_user.dart';
import 'package:matseonim/pages/my_mhi_page.dart';
import 'package:matseonim/pages/my_msi_page.dart';
import 'package:matseonim/pages/my_profile_page.dart';
import 'package:matseonim/pages/request_page.dart';
import 'package:matseonim/pages/settings_page.dart';

class DrawerPage extends StatelessWidget {
  final MSIUser user = MSIUser();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              child: DrawerHeader(
                child: Column(
                  children: [
                    Row(children: [
                      CustomCircleAvatar(size: 84, url: user.avatarUrl ?? ""),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.name ?? "(이름)",
                              style: const TextStyle(
                                fontSize: 32,
                              )),
                          SizedBox(height: 8),
                          Text(user.baseName ?? "(부대 명칭)",
                              style: const TextStyle(
                                fontSize: 16,
                              )),
                        ],
                      )
                    ])
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text('내 정보'),
              onTap: () {
                Get.to(MyProfilePage());
              },
            ),
            ListTile(
              title: const Text('내 맞선임'),
              onTap: () {
                Get.to(MyMSIPage());
              },
            ),
            ListTile(
              title: const Text('내 맞후임'),
              onTap: () {
                Get.to(MyMHIPage());
              },
            ),
            ListTile(
              title: const Text('새로운 의뢰'),
              onTap: () {
                Get.to(RequestPage());
              },
            ),
            ListTile(
              title: const Text('환경설정'),
              onTap: () {
                Get.to(SettingsPage());
              },
            ),
          ],
        ),
      )
    );
  }
}
