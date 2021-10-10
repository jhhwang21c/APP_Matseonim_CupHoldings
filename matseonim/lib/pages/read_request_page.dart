import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:matseonim/components/custom_app_bar.dart';
import 'package:matseonim/components/custom_elevated_button.dart';
import 'package:matseonim/components/custom_profile_widgets.dart';
import 'package:matseonim/models/request.dart';
import 'package:matseonim/pages/drawer_page.dart';

class ReadRequestPage extends StatelessWidget {
  final MSIRequest request;

  const ReadRequestPage({Key? key, required this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showBackButton: true),
      drawer: DrawerPage(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "의뢰 내용", 
                style: TextStyle(fontSize: 32)
              ),
            ),
            MidProfile(uid: request.uid),
            const SizedBox(height: 30),
            Text(
              request.title, 
              style: const TextStyle(fontSize: 32)
            ),
            const SizedBox(height: 10),
            Text(
              "요청 분야: ${request.field}", 
              style: const TextStyle(fontSize: 16)
            ),
            const SizedBox(height: 10),
            Text(
              request.description, 
              style: const TextStyle(fontSize: 16)
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomElevatedButton(
                text: "요청 수락",
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.white
                ),
                color: Theme.of(context).primaryColor,
                funPageRoute: () {}
              )
            )
          ],
        ),
      ),
    );
  }
}
