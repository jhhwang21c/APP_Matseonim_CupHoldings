import 'package:flutter/material.dart';
import 'pages/join_page.dart';
import 'package:matseonim/theme.dart';

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
