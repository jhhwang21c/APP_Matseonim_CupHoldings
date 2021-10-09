import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_app_bar.dart';
import 'package:matseonim/components/custom_elevated_button.dart';
import 'package:matseonim/components/custom_carousel_slider.dart';
import 'package:matseonim/components/custom_profile_widgets.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/pages/drawer_page.dart';
import 'package:matseonim/pages/request_page.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MSIUser.init(),
      builder: (BuildContext context, AsyncSnapshot<MSIUser> snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: CustomAppBar(),
            drawer: DrawerPage(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator()
              )
            )
          );
        } else {
          final MSIUser user = snapshot.data!;

          return Scaffold(
            appBar: CustomAppBar(),
            drawer: DrawerPage(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "새로운 사연",
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ItemSlider(),
                      const SizedBox(height: 20),
                      CustomElevatedButton(
                        text: "의뢰 요청하기",
                        textStyle: const TextStyle(
                          fontSize: 16, 
                          color: Colors.black
                        ),
                         color: Colors.lightBlue[300],
                        funPageRoute: () {
                          Get.to(RequestPage());
                        }
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "내 맞선임",
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SmallProfileListView(uidList: user.msiList ?? [])
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
                      SmallProfileListView(uidList: user.mhiList ?? [])
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
                      SmallProfileListView(uidList: user.reqList ?? [])
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      }
    );
  }
}
