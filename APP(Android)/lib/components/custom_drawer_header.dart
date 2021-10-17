import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_circle_avatar.dart';
import 'package:matseonim/components/custom_elevated_button.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/pages/login_page.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: DrawerHeader(
        child: FutureBuilder(
          future: MSIUser.init(),
          builder: (BuildContext context, AsyncSnapshot<MSIUser> snapshot) {
            if (!snapshot.hasData) {
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator()
              );
            } else {
              final MSIUser user = snapshot.data!;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _DrawerProfile(user: user),
                  SizedBox(height: 16),
                  CustomElevatedButton(
                    text: '로그아웃',
                    size: Size(double.infinity, 36),
                    color: Colors.yellow[300],
                    funPageRoute: () async {
                      await user.logout();
                      Get.to(LoginPage());
                    },
                  )
                ],
              );
            }
          }
        )
      )
    );
  }
}

class _DrawerProfile extends StatelessWidget {
  final MSIUser user;

  const _DrawerProfile({
    Key? key, 
    required this.user
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCircleAvatar(size: 80, url: user.avatarUrl ?? ""),
        SizedBox(width: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.name ?? "(이름)",
              style: const TextStyle(
                fontSize: 32,
              )
            ),
            SizedBox(height: 8),
            Text(user.baseName ?? "(부대 명칭)",
              style: const TextStyle(
                fontSize: 16,
              )
            ),
          ],
        )
      ]
    );
  }

}
