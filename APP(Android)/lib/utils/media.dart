import 'package:flutter/material.dart';

/// 사용자 기기의 화면 가로 길이를 반환한다. 
double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

/// 사용자 기기의 화면 세로 길이를 반환한다. 
double getScreenHeight(BuildContext context, {bool excludeToolbar = true}) {
  return MediaQuery.of(context).size.height 
    - (excludeToolbar ? kToolbarHeight : 0);
}