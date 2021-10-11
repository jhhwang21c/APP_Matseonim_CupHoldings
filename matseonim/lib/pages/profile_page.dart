import 'package:flutter/material.dart';

import 'package:matseonim/components/custom_profile_widgets.dart';
import 'package:matseonim/components/custom_app_bar.dart';
import 'package:matseonim/pages/drawer_page.dart';

class ProfilePage extends StatelessWidget {
  final String? uid;

  const ProfilePage({Key? key, this.uid}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: DrawerPage(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "프로필 페이지", 
                style: TextStyle(fontSize: 32)
              ),
            ),
            const SizedBox(height: 28),
            LargeProfile(uid: uid)
          ],
        ),
      ),
    );
  }
}
