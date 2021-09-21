import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matseonim/components/global_app_bar.dart';
import 'package:matseonim/pages/drawer.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(),
      drawer: DrawerPage(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: ListView(
          children: [
            const SizedBox(height: 20),  //검색창 넣기?
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
      children: [
        const SizedBox(
          width: 60,
          height: 60,
          child: CircleAvatar(
            backgroundImage:
                AssetImage("images/sampleAvatar.jpg"), // 이미지는 서버에서 불러와야함
          ),
        ),
        const SizedBox(height: 10),
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
