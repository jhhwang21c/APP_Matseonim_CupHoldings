import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matseonim/components/global_app_bar.dart';
import 'package:matseonim/pages/drawer.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(),
      drawer: DrawerPage(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [],
        ),
      ),
    );
  }
}
