import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_circle_avatar.dart';
import 'package:matseonim/components/custom_elevated_button.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/pages/main_profile_page.dart';

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
              child: const CircularProgressIndicator()
            )
          );
        } else {
          final MSIUser user = snapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                Row(
                  children: [
                    CustomCircleAvatar(size: 120, url: user.avatarUrl ?? ""),
                    const SizedBox(width: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name ?? "?",
                          style: const TextStyle(
                            fontSize: 32,
                          )
                        ),
                        SizedBox(height: 10),
                        Text(
                          user.baseName ?? "?",
                          style: const TextStyle(
                            fontSize: 16,
                          )
                        ),
                        SizedBox(height: 10),
                        Text(
                          "분야: ${user.interest ?? ""}",
                          style: const TextStyle(
                            fontSize: 16,
                          )
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(
                              MainProfilePage(
                                uid: user.uid
                              )
                            );
                          },
                          child: Text("자세히 >>"),
                        )
                      ]
                    )
                  ]
                ),
                SizedBox(height: 10),
                CustomElevatedButton(
                  text: "채팅하기",
                  color: Colors.lightBlue,
                  funPageRoute: () {}
                  )
                ]
              )
            ]
          );
        }
      }
    );
  }
}

class SmallProfile extends StatelessWidget {
  final String? uid;
  
  const SmallProfile({Key? key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MSIUser.init(uid: uid),
      builder: (BuildContext context, AsyncSnapshot<MSIUser> snapshot) {  
        if (!snapshot.hasData) {
          return SizedBox(
            child: Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator()
            )
          );
        } else {
          final MSIUser user = snapshot.data!;

          return Column(
            children: [
              CustomCircleAvatar(size: 60, url: user.avatarUrl ?? ""),
              SizedBox(height: 10),
              Text(
                user.name ?? "",
                style: const TextStyle(
                  fontSize: 16
                )
              ),
              Text(
                user.profession ?? "",
                style: TextStyle(
                  fontSize: 16
                ),
              ),
            ],
          );
        }
      }
    );
  }
}
