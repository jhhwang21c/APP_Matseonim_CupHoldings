import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:matseonim/components/custom_app_bar.dart';
import 'package:matseonim/components/custom_profile_widgets.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/pages/drawer_page.dart';

class NewRequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: DrawerPage(),
      body: FutureBuilder(
        future: MSIUser.init(),
        builder: (BuildContext context, AsyncSnapshot<MSIUser> snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator()
              )
            );
          } else {
            final MSIUser user = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text("새로운 의뢰", style: TextStyle(fontSize: 32)),
                  ),
                  MidProfileListView(uidList: /* TODO: 새로운 의뢰 목록 보여주기 */ [])
                ],
              ),
            );
          }
        }
      )
    );
  }
}
