import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:matseonim/theme.dart';
import 'package:matseonim/pages/login_page.dart';

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
      home: LoginPage(),
    );
  }
}
