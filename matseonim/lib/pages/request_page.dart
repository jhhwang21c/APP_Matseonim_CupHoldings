import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:matseonim/components/custom_app_bar.dart';
import 'package:matseonim/components/mid_profile.dart';
import 'package:matseonim/pages/drawer_page.dart';

class MyMHIPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: DrawerPage(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Text("의뢰 요청"),
            MidProfile(),
            MidProfile(),
          ],
        ),
      ),
    );
  }
}
