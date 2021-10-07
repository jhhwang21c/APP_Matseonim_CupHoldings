import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_app_bar.dart';
import 'package:matseonim/components/custom_elevated_button.dart';
import 'package:matseonim/components/item_slider.dart';
import 'package:matseonim/components/small_profile.dart';
import 'package:matseonim/pages/drawer_page.dart';
import 'package:matseonim/pages/request_page.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: DrawerPage(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                itemSlider(),
                SizedBox(height: 20),
                CustomElevatedButton(
                      text: "새 의뢰 요청하기",
                      textStyle:
                          const TextStyle(fontSize: 16, color: Colors.white),
                      color: Theme.of(context).primaryColor,
                      funPageRoute: () {
                        Get.to(RequestPage());
                      }),
                SizedBox(height: 20),
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
                      SmallProfile(),
                      const SizedBox(width: 25),
                      SmallProfile(),
                      const SizedBox(width: 25),
                      SmallProfile(),
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
                      SmallProfile(),
                      const SizedBox(width: 25),
                      SmallProfile(),
                      const SizedBox(width: 25),
                      SmallProfile(),
                      const SizedBox(width: 25),
                      SmallProfile(),
                      const SizedBox(width: 25),
                      SmallProfile(),
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
                      SmallProfile(),
                      const SizedBox(width: 25),
                      SmallProfile(),
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
                      SmallProfile(),
                      const SizedBox(width: 25),
                      SmallProfile(),
                      const SizedBox(width: 25),
                      SmallProfile(),
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
}
