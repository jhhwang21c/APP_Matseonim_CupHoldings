import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_circle_avatar.dart';
import 'package:matseonim/database/msi_user.dart';

class DrawerPage extends StatelessWidget {
  final MSIUser? user;

  const DrawerPage({this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('내 정보'),
                SizedBox(height: 20),
                Row(children: [
                  CustomCircleAvatar(
                    size: 80,
                    url: user?.avatarUrl ?? ""
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user?.name ?? "(이름)",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          )),
                      Text(user?.baseName ?? "(부대 명칭)",
                          style: const TextStyle(
                            fontSize: 16,
                          )),
                    ],
                  )
                ])
              ],
            ),
          ),
          ListTile(
            title: const Text('내 맞선임'),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            title: const Text('내 맞후임'),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            title: const Text('새로운 의뢰'),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            title: const Text('환경설정'),
            onTap: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
