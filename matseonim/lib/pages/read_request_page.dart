import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:matseonim/components/custom_app_bar.dart';
import 'package:matseonim/components/custom_profile_widgets.dart';
import 'package:matseonim/models/request.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/pages/drawer_page.dart';

class ReadRequestPage extends StatelessWidget {
  final MSIRequest request;
  final MSIUser? user;

  const ReadRequestPage({Key? key, required this.request, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: DrawerPage(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text("의뢰내용", style: TextStyle(fontSize: 32)),
            ),
            MidProfile(uid: request.uid),
            SizedBox(height: 30),
            //내용내용
          ],
        ),
      ),
    );
  }
}
