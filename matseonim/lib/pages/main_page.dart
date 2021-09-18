import 'package:flutter/material.dart';
import 'package:matseonim/pages/drawer.dart';

class MainPage extends StatelessWidget {
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("sample")),
      body: const Center(
        child: Text('My Page!'),
      ),
      drawer: DrawerPage(),
    );
  }
}