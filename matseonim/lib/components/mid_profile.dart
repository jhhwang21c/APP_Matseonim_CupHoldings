import 'package:flutter/material.dart';

import 'package:matseonim/components/custom_circle_avatar.dart';
import 'package:matseonim/components/custom_elevated_button.dart';
import 'package:matseonim/models/user.dart';

class MidProfile extends StatelessWidget {
  final MSIUser user = MSIUser();

  @override
  Widget build(BuildContext context) {
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
                    Text(user.name ?? "(이름)",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )),
                    Text(user.baseName ?? "(부대 명칭)",
                        style: const TextStyle(
                          fontSize: 16,
                        )),
                    Text("요청 분야: ${user.interest}",
                        style: const TextStyle(
                          fontSize: 16,
                        ))
                  ]
                )
              ]
            ),
            CustomElevatedButton(text: "채팅")
          ]
        )
      ]
    );
  }
}
