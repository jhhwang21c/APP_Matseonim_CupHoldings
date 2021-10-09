import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:matseonim/components/custom_app_bar.dart';
import 'package:matseonim/components/custom_profile_widgets.dart';
import 'package:matseonim/models/request.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/pages/drawer_page.dart';

class ReadRequestPage extends StatelessWidget {
  final MSIRequest request;

  const ReadRequestPage({Key? key, required this.request}) : super(key: key);

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
            Text("${request.title}", style: TextStyle(fontSize: 32),),
            SizedBox(height: 10),
            Text("요청분야: ${request.interest}", style: TextStyle(fontSize: 16),),
            SizedBox(height: 10),
            Text("${request.description}", style: TextStyle(fontSize: 16),),
          ],
        ),
      ),
    );
  }
}
