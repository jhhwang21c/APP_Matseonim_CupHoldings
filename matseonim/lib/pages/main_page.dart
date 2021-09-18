import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matseonim/pages/drawer.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: DrawerPage(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('맞선임'),
      centerTitle: true,
      backgroundColor: Colors.blue[900],
      elevation: 1.0,
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        SizedBox(width: 15),
      ],
    );
  }
}
