import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:matseonim/components/custom_app_bar.dart';
import 'package:matseonim/components/custom_profile_widgets.dart';
import 'package:matseonim/pages/drawer_page.dart';

class NewRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: DrawerPage(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text("새로운 의뢰", style: TextStyle(fontSize: 32)),
            ),
            MidProfile(),
            SizedBox(height: 30),
            MidProfile(),
          ],
        ),
      ),
    );
  }
}
