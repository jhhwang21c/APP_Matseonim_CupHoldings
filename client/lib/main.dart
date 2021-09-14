import 'package:flutter/material.dart';
import 'pages/join_page.dart';
import 'package:client/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: JoinPage(),
    );
  }
}
