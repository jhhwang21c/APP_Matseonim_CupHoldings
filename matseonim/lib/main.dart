import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:matseonim/theme.dart';
import 'package:matseonim/pages/join_page1.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: defaultTheme(),
      home: JoinPage1(),
    );
  }
}
