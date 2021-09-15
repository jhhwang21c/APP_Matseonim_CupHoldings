import 'package:flutter/material.dart';
import 'package:matseonim/theme.dart';

import 'package:matseonim/pages/join_page.dart';
import 'package:matseonim/pages/login_page.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: JoinPage(),
    );
  }
}
