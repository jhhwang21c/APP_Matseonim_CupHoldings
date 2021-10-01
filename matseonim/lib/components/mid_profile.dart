import 'package:flutter/material.dart';

import 'package:matseonim/components/custom_circle_avatar.dart';
import 'package:matseonim/components/custom_elevated_button.dart';
import 'package:matseonim/models/user.dart';

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
                      CustomCircleAvatar(size: 100, url: user.avatarUrl ?? ""),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start, 
                        children: [
                          Text(
                            user.name ?? "?",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            )
                          ),
                          Text(
                            user.baseName ?? "?",
                            style: const TextStyle(
                              fontSize: 16,
                            )
                          ),
                          Text(
                            "요청 분야: ${user.interest ?? "(없음)"}",
                            style: const TextStyle(
                              fontSize: 16,
                            )
                          )
                        ]
                      )
                    ]
                  ),
                  const CustomElevatedButton(text: "채팅")
                ]
              )
            ]
          );
        }
      }
    );
  }
}
