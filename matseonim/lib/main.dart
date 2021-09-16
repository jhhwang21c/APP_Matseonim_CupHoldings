import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kakao_flutter_sdk/common.dart';

import 'package:matseonim/theme.dart';
import 'package:matseonim/pages/join_part1.dart';

const String _kakaoNativeAppKey = "00e720cdadb5f87b4930ec8cc08179b4";

void main() {
  _initKakaoSDK();
  runApp(MainApp());
}

void _initKakaoSDK() {
  KakaoContext.clientId = _kakaoNativeAppKey;
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
