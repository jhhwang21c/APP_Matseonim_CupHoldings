import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_circle_avatar.dart';
import 'package:matseonim/database/msi_user.dart';

class DrawerPage extends StatelessWidget {
  final MSIUser user = MSIUser();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 124.0,
              child: DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      CustomCircleAvatar(
                        size: 84,
                        url: user.avatarUrl ?? ""
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.name ?? "(이름)",
                              style: const TextStyle(
                                fontSize: 16,
                              )),
                          SizedBox(height: 8),
                          Text(user.baseName ?? "(부대 명칭)",
                              style: const TextStyle(
                                fontSize: 16,
                              )),
                        ],
                      ),
                      Expanded(child: Container()),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        iconSize: 16.0,
                        onPressed: () { Get.back(); },
                      )
                    ])
                  ],
                ),
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
      )
    );
  }
}
