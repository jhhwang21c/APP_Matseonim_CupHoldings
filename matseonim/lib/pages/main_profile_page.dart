import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_circle_avatar.dart';
import 'package:matseonim/components/custom_elevated_button.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/components/custom_app_bar.dart';
import 'package:matseonim/components/mid_profile.dart';
import 'package:matseonim/pages/drawer_page.dart';

class MainProfilePage extends StatelessWidget {
  final String? uid;

  const MainProfilePage({Key? key, this.uid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: DrawerPage(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder(
            future: MSIUser.init(uid: uid),
            builder: (BuildContext context, AsyncSnapshot<MSIUser> snapshot) {
              if (!snapshot.hasData) {
                return SizedBox(
                    child: Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator()));
              } else {
                final MSIUser user = snapshot.data!;

                return ListView(children: [
                  CustomCircleAvatar(size: 120, url: user.avatarUrl ?? ""),
                  const SizedBox(width: 40),
                  Text(user.name ?? "?",
                      style: const TextStyle(
                        fontSize: 32,
                      )),
                  SizedBox(height: 10),
                  Text(user.baseName ?? "?",
                      style: const TextStyle(
                        fontSize: 16,
                      )),
                  SizedBox(height: 10),
                  Text("분야: ${user.interest ?? "(없음)"}",
                      style: const TextStyle(
                        fontSize: 16,
                      )),
                  SizedBox(height: 10),
                  Text("경력: ${user.interest ?? "(없음)"}",
                      style: const TextStyle(
                        fontSize: 16,
                      )),
                  CustomElevatedButton(
                      text: "채팅하기",
                      color: Colors.lightBlue,
                      funPageRoute: () {}),
                ]);
              }
            }),
      ),
    );
  }
}
