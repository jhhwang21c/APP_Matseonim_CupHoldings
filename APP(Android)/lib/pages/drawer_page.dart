import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_drawer_header.dart';
import 'package:matseonim/pages/create_request_page.dart';
import 'package:matseonim/pages/main_page.dart';
import 'package:matseonim/pages/my_mhi_page.dart';
import 'package:matseonim/pages/my_msi_page.dart';
import 'package:matseonim/pages/my_account_page.dart';
import 'package:matseonim/pages/inquiry_page.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          CustomDrawerHeader(),
          ListTile(
            title: const Text('홈 화면'),
            onTap: () async {
              Get.to(MainPage());
            }
          ),
          ListTile(
            title: const Text('내 정보'),
            onTap: () async {
              Get.to(MyAccountPage1());
            }
          ),
          ListTile(
            title: const Text('의뢰하기'),
            onTap: () async {
              Get.to(CreateRequestPage());
            }
          ),
          ListTile(
            title: const Text('내 맞선임'),
            onTap: () async {
              Get.to(MyMSIPage());
            }
          ),
          ListTile(
            title: const Text('내 맞후임'),
            onTap: () async {
              Get.to(MyMHIPage());
            }
          ),
          ListTile(
            title: const Text('문의하기'),
            onTap: () async {
              Get.to(InquiryPage());
            }
          ),
        ],
      )
    );
  }
}
