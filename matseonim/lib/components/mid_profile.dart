import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_circle_avatar.dart';
import 'package:matseonim/components/custom_elevated_button.dart';
import 'package:matseonim/models/user.dart';

import 'package:matseonim/pages/main_page.dart';

class MidProfile extends StatelessWidget {
  final String? uid;

  const MidProfile({Key? key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MSIUser.init(uid: uid),
        builder: (BuildContext context, AsyncSnapshot<MSIUser> snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
                child: Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator()));
          } else {
            final MSIUser user = snapshot.data!;

            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(children: [
                    Row(children: [
                      CustomCircleAvatar(size: 120, url: user.avatarUrl ?? ""),
                      const SizedBox(width: 40),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.name ?? "?",
                                style: const TextStyle(
                                  fontSize: 32,
                                )),
                            SizedBox(height:10),
                            Text(user.baseName ?? "?",
                                style: const TextStyle(
                                  fontSize: 16,
                                )),
                            SizedBox(height:10),
                            Text("분야: ${user.interest ?? "(없음)"}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ))
                          ])
                    ]),
                    SizedBox(height: 10),
                    CustomElevatedButton(
                        text: "채팅하기",
                        color: Colors.lightBlue,
                        funPageRoute: () {}),
                  ])
                ]);
          }
        });
  }
}
