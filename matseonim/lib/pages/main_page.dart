import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:matseonim/components/custom_app_bar.dart';
import 'package:matseonim/database/msi_user.dart';
import 'package:matseonim/pages/drawer_page.dart';

class MainPage extends StatelessWidget {
  final MSIUser? user;

  const MainPage({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: DrawerPage(user: user),
      drawerEnableOpenDragGesture: false,
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: ListView(
          children: [
            const SizedBox(height: 20), // TODO: 검색창 넣기?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "내 맞선임",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildSmallProfile(),
                      const SizedBox(width: 25),
                      _buildSmallProfile(),
                      const SizedBox(width: 25),
                      _buildSmallProfile(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "내 맞후임",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildSmallProfile(),
                      const SizedBox(width: 25),
                      _buildSmallProfile(),
                      const SizedBox(width: 25),
                      _buildSmallProfile(),
                      const SizedBox(width: 25),
                      _buildSmallProfile(),
                      const SizedBox(width: 25),
                      _buildSmallProfile(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "새로운 의뢰",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildSmallProfile(),
                      const SizedBox(width: 25),
                      _buildSmallProfile(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "부대 상위 맞선임들",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildSmallProfile(),
                      const SizedBox(width: 25),
                      _buildSmallProfile(),
                      const SizedBox(width: 25),
                      _buildSmallProfile(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallProfile() {
    return Column(
      children: const [
        SizedBox(
          width: 60,
          height: 60,
          child: CircleAvatar(
            backgroundImage:
                AssetImage("images/sampleAvatar.jpg"), // TODO: 서버에서 이미지 불러오기
          ),
        ),
        SizedBox(height: 10),
        Text(
          "홍길동",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "헬스",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
