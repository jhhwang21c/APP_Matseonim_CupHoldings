import 'package:flutter/material.dart';

import 'package:matseonim/components/custom_app_bar.dart';
import 'package:matseonim/components/custom_circle_avatar.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/pages/drawer_page.dart';

class MyAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: DrawerPage(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _EditableProfile()
      )
    );
  }
}

class _EditableProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MSIUser.init(),
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
          
          return ListView(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      "내 정보",
                      style: TextStyle(
                        fontSize: 32
                      )
                    ),
                    const SizedBox(height: 32),
                    _EditableAvatar(user: user),
                    const SizedBox(height: 32)
                  ],                  
                )
              )
            ]
          );
        }
      }
    );
  }
}

class _EditableAvatar extends StatelessWidget {
  final MSIUser user;

  const _EditableAvatar({
    Key? key,
    required this.user
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomCircleAvatar(size: 250, url: user.avatarUrl ?? ""),
        Positioned(
          right: 0,
          bottom: 0,
          child: ElevatedButton(
            onPressed: () {
              /* TODO: ... */
            },
            child: const Icon(Icons.edit),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
              primary: Theme.of(context).primaryColor
            ),
          )
        )
      ]
    );
  }
}