import 'package:flutter/material.dart';

import 'package:matseonim/components/custom_circle_avatar.dart';
import 'package:matseonim/models/user.dart';

class LargeProfile extends StatelessWidget {
  final String? uid;
  
  const LargeProfile({Key? key, this.uid}) : super(key: key);

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
          
          // TODO: 나머지 부분 추가
          return Column(
            children: [
              CustomCircleAvatar(size: 250, url: user.avatarUrl ?? "")
            ]
          );
        }
      }
    );
  }
}