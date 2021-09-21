import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/pages/main_page.dart';

class DrawerPage extends StatelessWidget {
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
                  _buildHeaderAvatar(),
                  SizedBox(width: 20),
                  _buildHeaderProfile(),
                ])
              ],
            ),
          ),
          ListTile(
            title: const Text('내 맞선임'),
            onTap: () {Get.to(MainPage());},
          ),
          ListTile(
            title: const Text('내 맞후임'),
            onTap: () {Get.to(MainPage());},
          ),
          ListTile(
            title: const Text('새로운 의뢰'),
            onTap: () {Get.to(MainPage());},
          ),
          ListTile(
            title: const Text('환경설정'),
            onTap: () {Get.to(MainPage());},
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderAvatar() {
    return SizedBox(
      width: 80,
      height: 80,
      child: CircleAvatar(
        backgroundImage: AssetImage("images/sampleAvatar.jpg"),
      ),
    );
  }

  Widget _buildHeaderProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("홍길동",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            )),
        Text("제20전투비행단",
            style: TextStyle(
              fontSize: 16,
            )),
      ],
    );
  }
}
