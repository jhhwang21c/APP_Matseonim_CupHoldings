import 'package:flutter/material.dart';

import 'package:matseonim/components/custom_app_bar.dart';
import 'package:matseonim/components/mid_profile.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/pages/drawer_page.dart';

class MyMSIPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: DrawerPage(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Text("내 맞선임"),
            FutureBuilder(
              future: MSIUser.init(),
              builder: (BuildContext context, AsyncSnapshot<MSIUser> snapshot) {  
                return MidProfile(user: snapshot.data);
              }
            ),
            FutureBuilder(
              future: MSIUser.init(),
              builder: (BuildContext context, AsyncSnapshot<MSIUser> snapshot) {  
                return MidProfile(user: snapshot.data);
              }
            )
          ],
        ),
      ),
    );
  }
}
