import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:matseonim/components/custom_circle_avatar.dart';
import 'package:matseonim/models/user.dart';

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
                user.name ?? "?",
                style: const TextStyle(
                  fontSize: 16
                )
              ),
              Text(
                user.profession ?? "(없음)",
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
